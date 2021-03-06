












module da_ffts

   
   
   

   use module_domain, only :domain
   use da_control, only : ims,ime,jms,jme,kms,kme,its,ite,jts,jte,kts,kte, &
      Inverse_FFT,  Forward_FFT, ids,jds, trace_use, &
      ide,jde, stdout
   use da_define_structures, only : xbx_type
   use da_par_util, only : da_transpose_x2z, da_transpose_y2x, &
      da_transpose_y2x_v2, da_transpose_z2x, da_transpose_x2y, &
      da_transpose_x2y_v2
   use da_tracing, only : da_trace_entry, da_trace_exit
   use da_wrf_interfaces, only : wrf_debug
   use module_dm, only : wrf_dm_sum_reals
   use module_dm, only : local_communicator, &
      ntasks_x, ntasks_y, data_order_xyz, mytask, ntasks
   use da_control, only : ids,ide,ips,ipe,jds,jde,jps,jpe,kds,kde,kps,kpe
   use module_comm_dm, only : halo_bal_eqn_adj_sub

   use module_ffts, only : fft661, fft551

   implicit none

   contains

subroutine da_solve_poissoneqn_fct(grid, xbx, del2b, b)

   !---------------------------------------------------------------------------
   ! Purpose: Solve Del**2 B = A for B with zero gradient boundary conditions.
   !
   ! Method:  1) Compute spectral del2b using double forward FCT.
   !          2) Calculate spectral b.
   !          3) Reform gridpt. b using inverse double FCT.
   !          4) Remove mean b (arbitrary constant).
   !--------------------------------------------------------------------------

   implicit none

   type(domain),     intent(inout) :: grid
   type(xbx_type),   intent(in)    :: xbx     ! Header & non-gridded vars.
   real,             intent(in)    :: del2b(ims:ime,jms:jme,kms:kme)   ! Del**2 B.
   real,             intent(out)   :: b(ims:ime,jms:jme,kms:kme)       ! B

   integer           :: vector_inc    ! Increment between FST data.
   integer           :: vector_jump   ! Jump between start of vectors.
   integer           :: vector_size   ! Of form 2**p 3**q 5**r for FSTs.
   integer           :: num_vectors   ! Number of FSTs to perform.
   integer           :: work_area     ! Dimension for FST routine.
   integer           :: idim          ! Size of 1st dimension for FST.
   integer           :: jdim          ! Size of 2nd dimension for FST.
   integer           :: i, j, k, n, ij     ! loop counter
   real, allocatable :: work_1d(:)     ! FFT work array
   real              :: global_mean(kts:kte)
   real              :: local_mean(kts:kte)
   real              :: rij

   if (trace_use) call da_trace_entry("da_solve_poissoneqn_fct")

   !---------------------------------------------------------------------------
   ! [1.0] Initialise:
   !---------------------------------------------------------------------------

   ! Calculate work space needed.

   n = max(xbx%fft_ix*(grid%xp%jtex-grid%xp%jtsx+1), &
           xbx%fft_jy*(grid%xp%itey-grid%xp%itsy+1+xbx%pad_num))

   ! Allocate work arrays.
   allocate(work_1d(1:n))

   ! Copy del2b for transpose.

   grid%xp%v1z(its:ite,jts:jte,kts:kte) = del2b(its:ite,jts:jte,kts:kte)

   ! if (ite == ide) grid%xp%v1z(ite,jts:jte,kts:kte) = 0.0
   ! if (jte == jde) grid%xp%v1z(its:ite,jte,kts:kte) = 0.0

   !---------------------------------------------------------------------------
   ! [2.0] Perform calculation of gridpoint b level by level:
   !---------------------------------------------------------------------------

   ! [2.1] Apply (i',j',k -> i,j',k') transpose (v1z -> v1x).

   call da_transpose_z2x (grid)

   ! [2.2] Set up FFT parameters:

   idim = xbx%fft_ix
   jdim = grid%xp%jtex-grid%xp%jtsx+1

   vector_inc  = 1
   vector_jump = idim
   vector_size = idim - 1

   num_vectors = jdim

   work_area   = (vector_size+1)*num_vectors


   ! [2.3] Perform forward FFT:

   do k = grid%xp%ktsx, grid%xp%ktex
      ij = 0
      do j=grid%xp%jtsx, grid%xp%jtex
         do i=ids, ide
            ij=ij+1
            work_1d(ij) = grid%xp%v1x(i,j,k)
         end do

         do i=1, xbx%fft_pad_i
            ij=ij+1
            work_1d(ij) = 0.0
         end do
      end do
      call fft551(Forward_FFT, vector_inc, vector_jump, &
                                     num_vectors, vector_size, &
                                     xbx%fft_factors_x, xbx%trig_functs_x, &
                                     work_1d(1), work_area)
      
      ij = 0
      do j=grid%xp%jtsx, grid%xp%jtex
         do i=ids, ide
            ij=ij+1
            grid%xp%v1x(i,j,k) = work_1d(ij)
         end do

         do n=1, xbx%fft_pad_i
            i=(n-1)*xbx%pad_inc + 1
            ij=ij+1
            grid%xp%v2x(i,j,k) = work_1d(ij)
         end do
      end do
   end do

   !---------------------------------------------------------------------------
   ! [3.0] For each k-level, perform forward FFT in y direction, apply spectral
   !       Poisson equation, and then perform inverse FFT in y direction:
   !---------------------------------------------------------------------------

   ! [3.1] Apply (i,j',k' -> i',j,k') transpose (v1x -> v1y).

   call da_transpose_x2y (grid)
   call da_transpose_x2y_v2 (grid)

   ! [3.2] Set up FFT parameters:

   idim = grid%xp%itey - grid%xp%itsy + 1 + xbx%pad_num
   jdim = xbx%fft_jy

   vector_inc  = idim
   vector_jump = 1
   vector_size = jdim - 1
   num_vectors = idim

   work_area   = (vector_size+1)*num_vectors


   ! [2.3] Perform forward FFT in j:

   do k = grid%xp%ktsy, grid%xp%ktey
      ij = 0
      do j=jds, jde
         do i=grid%xp%itsy, grid%xp%itey
            ij=ij+1
            work_1d(ij) = grid%xp%v1y(i,j,k)
         end do

         do n=1, xbx%pad_num
            i=xbx%pad_loc(n)
            ij=ij+1
            work_1d(ij) = grid%xp%v2y(i,j,k)
         end do
      end do

      do j=1, xbx%fft_pad_j
         do i=grid%xp%itsy, grid%xp%itey+xbx%pad_num
            ij=ij+1
            work_1d(ij) = 0.0
         end do
      end do

      call fft551(Forward_FFT, vector_inc, vector_jump, &
                                   num_vectors, vector_size, &
                                   xbx % fft_factors_y, xbx % trig_functs_y, &
                                   work_1d(1), work_area)

      !------------------------------------------------------------------------
      ! [4.0] Solve spectral Poisson equation:
      !------------------------------------------------------------------------

      ij = 0
      do j=grid%xp%jds, xbx%fft_jy
         do i=grid%xp%itsy, grid%xp%itey
            ij=ij+1
            work_1d(ij) = xbx%fft_coeffs(i,j)*work_1d(ij)
         end do
         do n=1, xbx%pad_num
            i=xbx%pad_pos(n)
            ij=ij+1
            work_1d(ij) = xbx%fft_coeffs(i,j)*work_1d(ij)
         end do
      end do

      ! [2.3] Reform gridpt. b using inverse double FST in i.

      call fft551(Inverse_FFT, vector_inc, vector_jump, &
                                     num_vectors, vector_size, &
                                   xbx % fft_factors_y, xbx % trig_functs_y, &
                                   work_1d(1), work_area)

      ij = 0
      do j=jds, jde
         do i=grid%xp%itsy, grid%xp%itey
            ij=ij+1
            grid%xp%v1y(i,j,k) = work_1d(ij)
         end do

         do n=1, xbx%pad_num
            i=xbx%pad_loc(n)
            ij=ij+1
            grid%xp%v2y(i,j,k) = work_1d(ij)
         end do
      end do
   end do

   !---------------------------------------------------------------------------
   ! Perform inverse FFT in x direction:
   !---------------------------------------------------------------------------

   ! Apply (i',j,k' -> i,j',k') transpose (v1y -> v1x).

   call da_transpose_y2x (grid)
   call da_transpose_y2x_v2 (grid)

   ! Set up FFT parameters:

   idim = xbx%fft_ix
   jdim = grid%xp%jtex-grid%xp%jtsx+1

   vector_inc  = 1
   vector_jump = idim
   vector_size = idim - 1

   num_vectors = jdim

   work_area   = (vector_size+1)*num_vectors

   do k = grid%xp%ktsx, grid%xp%ktex
      ij = 0
      do j=grid%xp%jtsx, grid%xp%jtex
         do i=ids, ide
            ij=ij+1
            work_1d(ij) = grid%xp%v1x(i,j,k)
         end do

         do n=1, xbx%fft_pad_i
            i=(n-1)*xbx%pad_inc + 1
            ij=ij+1
            work_1d(ij) = grid%xp%v2x(i,j,k)
         end do
      end do

      call fft551(Inverse_FFT, vector_inc, vector_jump, &
                                     num_vectors, vector_size, &
                                     xbx % fft_factors_x, xbx % trig_functs_x, &
                                     work_1d(1), work_area)
      ij = 0
      do j=grid%xp%jtsx, grid%xp%jtex
         do i=ids, ide
            ij=ij+1
            grid%xp%v1x(i,j,k) = work_1d(ij)
         end do

         ij=ij+xbx%fft_pad_i
      end do
   end do

   ! Apply (i,j',k') -> i',j',k) transpose to restore v1z.

   call da_transpose_x2z (grid)

   ! Remove mean b (set arbitrary constant to zero):

   rij = 1.0/real((ide-ids+1)*(jde-jds+1))

   do k=kts, kte
      local_mean(k) = sum(grid%xp%v1z(its:ite,jts:jte,k))*rij
   end do

   call wrf_dm_sum_reals (local_mean, global_mean)

   do k=kts,kte
      write (unit=stdout,fmt=*) 'TEST_COVERAGE_DA_Solve_PoissonEqn_FCT:  global_mean(', &
         k,') = ', global_mean(k)
   end do

   ! [2.5] Write data array into b:

   do k=kts, kte
      b(its:ite,jts:jte,k) = grid%xp%v1z(its:ite,jts:jte,k) - global_mean(k)
   end do

   !---------------------------------------------------------------------------
   ! [5.0] Tidy up:
   !---------------------------------------------------------------------------

   if (allocated(work_1d)) deallocate(work_1d)

   if (trace_use) call da_trace_exit("da_solve_poissoneqn_fct")

end subroutine da_solve_poissoneqn_fct


subroutine da_solve_poissoneqn_fct_adj(grid, xbx, b, del2b)

   !---------------------------------------------------------------------------
   !  Purpose: Solve Del**2 B = A for B with zero gradient boundary conditions.
   !
   !  Method:  1) Compute spectral del2b using double forward FCT.
   !           2) Calculate spectral b.
   !           3) Reform gridpt. b using inverse double FCT.
   !           4) Remove mean b (arbitrary constant).
   !---------------------------------------------------------------------------

   implicit none

   type(domain),     intent(inout) :: grid
   type(xbx_type),   intent(in)    :: xbx     ! Header & non-gridded vars.
   real,             intent(inout) :: del2b(ims:ime,jms:jme,kms:kme)   ! Del**2 B.
   real,             intent(in)    :: b(ims:ime,jms:jme,kms:kme)       ! B

   integer           :: vector_inc    ! Increment between FST data.
   integer           :: vector_jump   ! Jump between start of vectors.
   integer           :: vector_size   ! Of form 2**p 3**q 5**r for FSTs.
   integer           :: num_vectors   ! Number of FSTs to perform.
   integer           :: work_area     ! Dimension for FST routine.
   integer           :: idim          ! Size of 1st dimension for FST.
   integer           :: jdim          ! Size of 2nd dimension for FST.

   integer           :: i, j, k, n, ij     ! loop counter

   real, allocatable :: work_1d(:)     ! FFT work array

   real              :: global_mean(kts:kte)
   real              :: local_mean(kts:kte)

   real              :: rij

   if (trace_use) call da_trace_entry("da_solve_poissoneqn_fct_adj")

   !---------------------------------------------------------------------------
   ! [1.0] Initialise:
   !---------------------------------------------------------------------------

   ! Calculate work space needed.

   n = max(xbx%fft_ix*(grid%xp%jtex-grid%xp%jtsx+1), &
           xbx%fft_jy*(grid%xp%itey-grid%xp%itsy+1+xbx%pad_num))

   ! Allocate work arrays.
   allocate(work_1d(1:n))

   ! Remove mean b (set arbitrary constant to zero):

   rij = 1.0/real((grid%xp%ite-grid%xp%its)*(grid%xp%jte-grid%xp%jts))

   do k=grid%xp%kts, grid%xp%kte
      local_mean(k) = sum(b(grid%xp%its:grid%xp%ite,grid%xp%jts:grid%xp%jte,k))*rij
   end do

   call wrf_dm_sum_reals (local_mean, global_mean)
   do k=grid%xp%kts,grid%xp%kte
      write (unit=stdout,fmt=*)  &
         'TEST_COVERAGE_da_solve_poissoneqn_fct_adj:  global_mean(',k,') = ', &
         global_mean(k)
   end do

   ! [2.5] Write data array into b:

   do k=grid%xp%kts, grid%xp%kte
      grid%xp%v1z(grid%xp%its:grid%xp%ite,grid%xp%jts:grid%xp%jte,k) = b(grid%xp%its:grid%xp%ite,grid%xp%jts:grid%xp%jte,k) &
         - global_mean(k)
   end do
      
   !---------------------------------------------------------------------------
   ! [2.0] Perform calculation of gridpoint b level by level:
   !---------------------------------------------------------------------------

   ! [2.1] Apply (i',j',k -> i,j',k') transpose (v1z -> v1x).

   call da_transpose_z2x (grid)

   ! [2.2] Set up FFT parameters:
  
   idim = xbx%fft_ix
   jdim = grid%xp%jtex - grid%xp%jtsx + 1

   vector_inc  = 1
   vector_jump = idim
   vector_size = idim - 1

   num_vectors = jdim

   work_area   = (vector_size+1)*num_vectors

   ! [2.3] Perform forward FFT:

   do k = grid%xp%ktsx, grid%xp%ktex
      ij = 0
      do j=grid%xp%jtsx, grid%xp%jtex
         do i=grid%xp%ids, grid%xp%ide
            ij=ij+1
            work_1d(ij) = grid%xp%v1x(i,j,k)
         end do

         do n=1, xbx%fft_pad_i
            ij=ij+1
            work_1d(ij) = 0.0
         end do
      end do

      call fft551(Forward_FFT, vector_inc, vector_jump, &
                                     num_vectors, vector_size, &
                                     xbx % fft_factors_x, xbx % trig_functs_x, &
                                     work_1d(1), work_area)
      ij = 0
      do j=grid%xp%jtsx, grid%xp%jtex
         do i=grid%xp%ids, grid%xp%ide
            ij=ij+1
            grid%xp%v1x(i,j,k) = work_1d(ij)
         end do

         do n=1, xbx%fft_pad_i
            i=(n-1)*xbx%pad_inc+1
            ij=ij+1
            grid%xp%v2x(i,j,k) = work_1d(ij)
         end do
      end do
   end do

   !------------------------------------------------------------------------------
   ! [3.0] For each k-level, perform forward FFT in y direction, apply spectral
   !       Poisson equation, and then perform inverse FFT in x direction:
   !------------------------------------------------------------------------------

   ! [3.1] Apply (i,j',k' -> i',j,k') transpose (v1x -> v1y).

   call da_transpose_x2y (grid)
   call da_transpose_x2y_v2 (grid)

   ! [3.2] Set up FFT parameters:

   idim = grid%xp%itey - grid%xp%itsy + 1 + xbx%pad_num
   jdim = xbx%fft_jy

   vector_inc  = idim
   vector_jump = 1
   vector_size = jdim - 1
   num_vectors = idim

   work_area   = (vector_size+1)*num_vectors

   do k = grid%xp%ktsy, grid%xp%ktey
      ij = 0
      do j=grid%xp%jds, grid%xp%jde
         do i=grid%xp%itsy, grid%xp%itey
            ij=ij+1
            work_1d(ij) = grid%xp%v1y(i,j,k)
         end do

         do n=1, xbx%pad_num
            i=xbx%pad_loc(n)
            ij=ij+1
            work_1d(ij) = grid%xp%v2y(i,j,k)
         end do
      end do

      do j=1, xbx%fft_pad_j
         do i=grid%xp%itsy, grid%xp%itey+xbx%pad_num
            ij=ij+1
            work_1d(ij) = 0.0
         end do
      end do

      call fft551(Forward_FFT, vector_inc, vector_jump, &
                                   num_vectors, vector_size, &
                                   xbx % fft_factors_y, xbx % trig_functs_y, &
                                   work_1d(1), work_area)

      !------------------------------------------------------------------------
      ! [4.0] Solve spectral Poisson equation:
      !------------------------------------------------------------------------

      ij = 0
      do j=grid%xp%jds, xbx%fft_jy
         do i=grid%xp%itsy, grid%xp%itey
            ij=ij+1
            work_1d(ij) = xbx%fft_coeffs(i,j)*work_1d(ij)/xbx%fft_adjoint_factor
         end do
         do n=1, xbx%pad_num
            i=xbx%pad_pos(n)
            ij=ij+1
            work_1d(ij) = xbx%fft_coeffs(i,j)*work_1d(ij)/xbx%fft_adjoint_factor
         end do
      end do

      ! Reform gridpt. b using inverse double FST in i.

      call fft551(Inverse_FFT, vector_inc, vector_jump, &
                                   num_vectors, vector_size, &
                                   xbx % fft_factors_y, xbx % trig_functs_y, &
                                   work_1d(1), work_area)
      ij = 0
      do j=grid%xp%jds, grid%xp%jde
         do i=grid%xp%itsy, grid%xp%itey
            ij=ij+1
            grid%xp%v1y(i,j,k) = work_1d(ij)
         end do

         do n=1, xbx%pad_num
            i=xbx%pad_loc(n)
            ij=ij+1
            grid%xp%v2y(i,j,k) = work_1d(ij)
         end do
      end do
   end do

   !---------------------------------------------------------------------------
   ! Perform inverse FFT in x direction:
   !---------------------------------------------------------------------------

   ! Apply (i',j,k' -> i,j',k') transpose (v1y -> v1x).

   call da_transpose_y2x (grid)
   call da_transpose_y2x_v2 (grid)

   ! Set up FFT parameters:

   idim = xbx%fft_ix
   jdim = grid%xp%jtex - grid%xp%jtsx + 1

   vector_inc  = 1
   vector_jump = idim
   vector_size = idim - 1

   num_vectors = jdim

   work_area   = (vector_size+1)*num_vectors

   ! [2.3] Perform forward FFT:

   do k = grid%xp%ktsx, grid%xp%ktex
      ij = 0
      do j=grid%xp%jtsx, grid%xp%jtex
         do i=grid%xp%ids, grid%xp%ide
            ij=ij+1
            work_1d(ij) = grid%xp%v1x(i,j,k)
         end do

         do n=1, xbx%fft_pad_i
            i=(n-1)*xbx%pad_inc+1
            ij=ij+1
            work_1d(ij) = grid%xp%v2x(i,j,k)
         end do
      end do

      call fft551(Inverse_FFT, vector_inc, vector_jump, &
                                   num_vectors, vector_size, &
                                   xbx % fft_factors_x, xbx % trig_functs_x, &
                                   work_1d(1), work_area)

      ij = 0
      do j=grid%xp%jtsx, grid%xp%jtex
         do i=grid%xp%ids, grid%xp%ide
            ij=ij+1
            grid%xp%v1x(i,j,k) = work_1d(ij)*xbx%fft_adjoint_factor
         end do

         ij=ij+xbx%fft_pad_i
      end do
   end do

   ! Apply (i,j',k') -> i',j',k) transpose to restore v1z.

   call da_transpose_x2z (grid)

!STARTOFREGISTRYGENERATEDINCLUDE 'inc/HALO_BAL_EQN_ADJ.inc'
!
! WARNING This file is generated automatically by use_registry
! using the data base in the file named Registry.
! Do not edit.  Your changes to this file will be lost.
!
CALL HALO_BAL_EQN_ADJ_sub ( grid, &
  local_communicator, &
  mytask, ntasks, ntasks_x, ntasks_y, &
  ids, ide, jds, jde, kds, kde,       &
  ims, ime, jms, jme, kms, kme,       &
  ips, ipe, jps, jpe, kps, kpe )
!ENDOFREGISTRYGENERATEDINCLUDE

   ! [2.5] Write data array into del2b:

   del2b(ims:ime,jms:jme,kms:kme) = del2b(ims:ime,jms:jme,kms:kme) + grid%xp%v1z(ims:ime,jms:jme,kms:kme)

   !---------------------------------------------------------------------------
   ! [5.0] Tidy up:
   !---------------------------------------------------------------------------

   if (allocated(work_1d)) deallocate (work_1d)

   if (trace_use) call da_trace_exit("da_solve_poissoneqn_fct_adj")

end subroutine da_solve_poissoneqn_fct_adj


subroutine da_solve_poissoneqn_fst(grid, xbx, del2b, b)

   !--------------------------------------------------------------------------
   !  Purpose: Solve Del**2 B = A for B with zero field boundary conditions.
   !
   !  Method:  1) Compute spectral del2b using double forward FST.
   !           2) Calculate spectral b.
   !           3) Reform gridpt. b using inverse double FST.
   !           Note no mean removed (would make b.ne.0 at boundaries) so
   !           arbitrary constant still present.
   !--------------------------------------------------------------------------

   implicit none

   type (domain),   intent(inout) :: grid
   type (xbx_type), intent(in)    :: xbx           ! Header & non-gridded vars.
   real,            intent(in)    :: del2b(ims:ime,jms:jme,kms:kme)  ! Del**2 B.
   real,            intent(out)   :: b(ims:ime,jms:jme,kms:kme)  ! B.
   
   integer           :: vector_inc    ! Increment between FST data.
   integer           :: vector_jump   ! Jump between start of vectors.
   integer           :: vector_size   ! Of form 2**p 3**q 5**r for FSTs.
   integer           :: num_vectors   ! Number of FSTs to perform.
   integer           :: work_area     ! Dimension for FST routine.
   integer           :: idim          ! Size of 1st dimension for FST.
   integer           :: jdim          ! Size of 2nd dimension for FST.

   integer           :: i, j, k, n, ij     ! loop counter

   real, allocatable :: work_1d(:)     ! FFT work array

   if (trace_use) call da_trace_entry("da_solve_poissoneqn_fst")

   !------------------------------------------------------------------------------
   ! [1.0] Initialise:
   !------------------------------------------------------------------------------

   ! Calculate work space needed.

   n = max(xbx%fft_ix*(grid%xp%jtex-grid%xp%jtsx+1), &
           xbx%fft_jy*(grid%xp%itey-grid%xp%itsy+1+xbx%pad_num))

   ! Allocate work arrays.
   allocate(work_1d(1:n))

   ! Copy del2b for transpose.

   grid%xp%v1z(its:ite,jts:jte,kts:kte) = del2b(its:ite,jts:jte,kts:kte)

   if (ite == ide) grid%xp%v1z(ite,jts:jte,kts:kte) = 0.0
   if (jte == jde) grid%xp%v1z(its:ite,jte,kts:kte) = 0.0

   !---------------------------------------------------------------------------
   ! [2.0] Perform forward FFT in x direction:
   !---------------------------------------------------------------------------

   ! [2.1] Apply (i',j',k -> i,j',k') transpose (v1z -> v1x).

   call da_transpose_z2x (grid)

   ! [2.2] Set up FFT parameters:
   
   idim = xbx%fft_ix
   jdim = grid%xp%jtex-grid%xp%jtsx+1

   vector_inc  = 1
   vector_jump = idim
   vector_size = idim - 1

   num_vectors = jdim

   work_area   = (vector_size+1)*num_vectors

   ! [2.3] Perform forward FFT:

   do k = grid%xp%ktsx, grid%xp%ktex
      ij = 0
      do j=grid%xp%jtsx, grid%xp%jtex
         do i=ids, ide
            ij=ij+1
            work_1d(ij) = grid%xp%v1x(i,j,k)
         end do

         do i=1, xbx%fft_pad_i
            ij=ij+1
            work_1d(ij) = 0.0
         end do
      end do

      call fft661(Forward_FFT, vector_inc, vector_jump, &
         num_vectors, vector_size, &
         xbx % fft_factors_x, xbx % trig_functs_x, &
         work_1d(1), work_area)
      ij = 0
      do j=grid%xp%jtsx, grid%xp%jtex
         do i=ids, ide
            ij=ij+1
            grid%xp%v1x(i,j,k) = work_1d(ij)
         end do

         do n=1, xbx%fft_pad_i
            i=(n-1)*xbx%pad_inc + 1
            ij=ij+1
            grid%xp%v2x(i,j,k) = work_1d(ij)
         end do
      end do
   end do

   !---------------------------------------------------------------------------
   ! [3.0] For each k-level, perform forward FFT in y direction, apply spectral 
   !        Poisson equation, and then perform inverse FFT in y direction:
   !---------------------------------------------------------------------------

   ! [3.1] Apply (i,j',k' -> i',j,k') transpose (v1x -> v1y).

   call da_transpose_x2y (grid)
   call da_transpose_x2y_v2 (grid)

   ! [3.2] Set up FFT parameters:

   idim = grid%xp%itey - grid%xp%itsy + 1 + xbx%pad_num
   jdim = xbx%fft_jy

   vector_inc  = idim
   vector_jump = 1
   vector_size = jdim - 1
   num_vectors = idim

   work_area   = (vector_size+1)*num_vectors

   ! [2.3] Perform forward FFT in j:

   do k = grid%xp%ktsy, grid%xp%ktey
      ij = 0
      do j=jds,jde
         do i=grid%xp%itsy, grid%xp%itey
            ij=ij+1
            work_1d(ij) = grid%xp%v1y(i,j,k)
         end do

         do n=1, xbx%pad_num
            i=xbx%pad_loc(n)
            ij=ij+1
            work_1d(ij) = grid%xp%v2y(i,j,k)
         end do
      end do

      do j=1, xbx%fft_pad_j
         do i=grid%xp%itsy, grid%xp%itey+xbx%pad_num
            ij=ij+1
            work_1d(ij) = 0.0
         end do
      end do

      call fft661(Forward_FFT, vector_inc, vector_jump, &
         num_vectors, vector_size, &
         xbx % fft_factors_y, xbx % trig_functs_y, &
         work_1d(1), work_area)

      !------------------------------------------------------------------------
      ! [4.0] Solve spectral Poisson equation:
      !------------------------------------------------------------------------

      ij = 0
      do j=jds, xbx%fft_jy
         do i=grid%xp%itsy, grid%xp%itey
            ij=ij+1
            work_1d(ij) = xbx%fft_coeffs(i,j)*work_1d(ij)
         end do
         do n=1, xbx%pad_num
            i=xbx%pad_pos(n)
            ij=ij+1
            work_1d(ij) = xbx%fft_coeffs(i,j)*work_1d(ij)
         end do
      end do

      ! [2.3] Reform gridpt. b using inverse double FST in i.

      call fft661(Inverse_FFT, vector_inc, vector_jump, &
         num_vectors, vector_size, &
         xbx % fft_factors_y, xbx % trig_functs_y, &
         work_1d(1), work_area)
                          
      ij = 0
      do j=jds, jde
         do i=grid%xp%itsy, grid%xp%itey
            ij=ij+1
            grid%xp%v1y(i,j,k) = work_1d(ij)
         end do

         do n=1, xbx%pad_num
            i=xbx%pad_loc(n)
            ij=ij+1
            grid%xp%v2y(i,j,k) = work_1d(ij)
         end do
      end do
   end do

   !---------------------------------------------------------------------------
   ! Perform inverse FFT in x direction:
   !---------------------------------------------------------------------------

   ! Apply (i',j,k' -> i,j',k') transpose (v1y -> v1x).

   call da_transpose_y2x (grid)
   call da_transpose_y2x_v2 (grid)

   ! Set up FFT parameters:
   
   idim = xbx%fft_ix
   jdim = grid%xp%jtex-grid%xp%jtsx+1

   vector_inc  = 1
   vector_jump = idim
   vector_size = idim - 1

   num_vectors = jdim

   work_area   = (vector_size+1)*num_vectors

   do k = grid%xp%ktsx, grid%xp%ktex
      ij = 0
      do j=grid%xp%jtsx, grid%xp%jtex
         do i=grid%xp%ids, grid%xp%ide
            ij=ij+1
            work_1d(ij) = grid%xp%v1x(i,j,k)
         end do

         do n=1, xbx%fft_pad_i
            i=(n-1)*xbx%pad_inc + 1
            ij=ij+1
            work_1d(ij) = grid%xp%v2x(i,j,k)
         end do
      end do

      call fft661(Inverse_FFT, vector_inc, vector_jump, &
         num_vectors, vector_size, &
         xbx % fft_factors_x, xbx % trig_functs_x, &
         work_1d(1), work_area)
      ij = 0
      do j=grid%xp%jtsx, grid%xp%jtex
         do i=ids, ide
            ij=ij+1
            grid%xp%v1x(i,j,k) = work_1d(ij)
         end do

         ij=ij+xbx%fft_pad_i
      end do
   end do

   ! Apply (i,j',k') -> i',j',k) transpose to restore v1z.

   call da_transpose_x2z (grid)

   !---------------------------------------------------------------------------
   ! [5.0] Tidy up:
   !---------------------------------------------------------------------------

   if (allocated(work_1d)) deallocate(work_1d)

   ! [2.5] Write data array into b:

   b(its:ite,jts:jte,kts:kte) = grid%xp%v1z(its:ite,jts:jte,kts:kte)

   if (trace_use) call da_trace_exit("da_solve_poissoneqn_fst")

end subroutine da_solve_poissoneqn_fst


subroutine da_solve_poissoneqn_fst_adj(grid, xbx, b, del2b)

   !---------------------------------------------------------------------------
   !  Purpose: Solve Del**2 B = A for B with zero field boundary conditions.
   !
   !  Method:  1) Compute spectral del2b using double forward FST.
   !           2) Calculate spectral b.
   !           3) Reform gridpt. b using inverse double FST.
   !           Note no mean removed (would make b.ne.0 at boundaries) so
   !           arbitrary constant still present.
   !---------------------------------------------------------------------------

   implicit none

   type(domain),   intent(inout) :: grid
   type(xbx_type), intent(in)    :: xbx           ! Header & non-gridded vars.
   real,           intent(in)    :: b(ims:ime,jms:jme,kms:kme)      ! B.
   real,           intent(out)   :: del2b(ims:ime,jms:jme,kms:kme)  ! Del**2 B.
   
   integer           :: vector_inc    ! Increment between FST data.
   integer           :: vector_jump   ! Jump between start of vectors.
   integer           :: num_vectors   ! Number of FSTs to perform.
   integer           :: vector_size   ! Of form 2**p 3**q 5**r for FSTs.
   integer           :: work_area     ! Dimension for FST routine.
   integer           :: idim          ! Size of 1st dimension for FST.
   integer           :: jdim          ! Size of 2nd dimension for FST.

   integer           :: i, j, k, n, ij  ! loop counter

   real, allocatable :: work_1d(:)    ! FFT work array for x dir.

   if (trace_use) call da_trace_entry("da_solve_poissoneqn_fst_adj")

   !---------------------------------------------------------------------------
   ! [1.0] Initialise:
   !---------------------------------------------------------------------------

   ! Calculate work space needed.

   n = max(xbx%fft_ix*(grid%xp%jtex-grid%xp%jtsx+1), &
           xbx%fft_jy*(grid%xp%itey-grid%xp%itsy+1+xbx%pad_num))

   ! Allocate work arrays.
   allocate(work_1d(1:n))

   ! Copy b for transpose.

   grid%xp%v1z(its:ite,jts:jte,kts:kte) = b(its:ite,jts:jte,kts:kte)

   !---------------------------------------------------------------------------
   ! [2.0] Perform forward FFT in x direction:
   !---------------------------------------------------------------------------

   ! [2.1] Apply (i',j',k -> i,j',k') transpose (v1z -> v1x).

   call da_transpose_z2x (grid)

   ! [2.2] Set up FFT parameters:
   
   idim = xbx%fft_ix
   jdim = grid%xp%jtex - grid%xp%jtsx + 1

   vector_inc  = 1
   vector_jump = idim
   vector_size = idim - 1

   num_vectors = jdim

   work_area   = (vector_size+1)*num_vectors

   ! [2.3] Perform forward FFT:

   do k = grid%xp%ktsx, grid%xp%ktex
      ij = 0
      do j=grid%xp%jtsx, grid%xp%jtex
         do i=grid%xp%ids, grid%xp%ide
            ij=ij+1
            work_1d(ij) = grid%xp%v1x(i,j,k)
         end do

         do n=1, xbx%fft_pad_i
            ij=ij+1
            work_1d(ij) = 0.0
         end do
      end do

      call fft661(Forward_FFT, vector_inc, vector_jump, &
                                   num_vectors, vector_size, &
                                   xbx % fft_factors_x, xbx % trig_functs_x, &
                                   work_1d(1), work_area)
      ij = 0
      do j=grid%xp%jtsx, grid%xp%jtex
         do i=grid%xp%ids, grid%xp%ide
            ij=ij+1
            grid%xp%v1x(i,j,k) = work_1d(ij)
         end do

         do n=1, xbx%fft_pad_i
            i=(n-1)*xbx%pad_inc+1
            ij=ij+1
            grid%xp%v2x(i,j,k) = work_1d(ij)
         end do
      end do
   end do

   !---------------------------------------------------------------------------
   ! [3.0] For each k-level, perform forward FFT in y direction, apply spectral 
   !       Poisson equation, and then perform inverse FFT in x direction:
   !---------------------------------------------------------------------------

   ! [3.1] Apply (i,j',k' -> i',j,k') transpose (v1x -> v1y).

   call da_transpose_x2y (grid)
   call da_transpose_x2y_v2 (grid)

   ! [3.2] Set up FFT parameters:

   idim = grid%xp%itey - grid%xp%itsy + 1 + xbx%pad_num
   jdim = xbx%fft_jy

   vector_inc  = idim
   vector_jump = 1
   vector_size = jdim - 1
   num_vectors = idim

   work_area   = (vector_size+1)*num_vectors

   do k = grid%xp%ktsy, grid%xp%ktey
      ij = 0
      do j=jds, jde
         do i=grid%xp%itsy, grid%xp%itey
            ij=ij+1
            work_1d(ij) = grid%xp%v1y(i,j,k)
         end do

         do n=1, xbx%pad_num
            i=xbx%pad_loc(n)
            ij=ij+1
            work_1d(ij) = grid%xp%v2y(i,j,k)
         end do
      end do

      do j=1, xbx%fft_pad_j
         do i=grid%xp%itsy, grid%xp%itey+xbx%pad_num
            ij=ij+1
            work_1d(ij) = 0.0
         end do
      end do

      call fft661(Forward_FFT, vector_inc, vector_jump, &
         num_vectors, vector_size, &
         xbx % fft_factors_y, xbx % trig_functs_y, &
         work_1d(1), work_area)

      !------------------------------------------------------------------------
      ! [4.0] Solve spectral Poisson equation:
      !------------------------------------------------------------------------

      ij = 0
      do j=jds, xbx%fft_jy
         do i=grid%xp%itsy, grid%xp%itey
            ij=ij+1
            work_1d(ij) = xbx%fft_coeffs(i,j)*work_1d(ij)/xbx%fft_adjoint_factor
         end do
         do n=1, xbx%pad_num
            i=xbx%pad_pos(n)
            ij=ij+1
            work_1d(ij) = xbx%fft_coeffs(i,j)*work_1d(ij)/xbx%fft_adjoint_factor
         end do
      end do

      ! Reform gridpt. b using inverse double FST in i.

      call fft661(Inverse_FFT, vector_inc, vector_jump, &
         num_vectors, vector_size, &
         xbx % fft_factors_y, xbx % trig_functs_y, &
         work_1d(1), work_area)
      ij = 0
      do j=jds, jde
         do i=grid%xp%itsy, grid%xp%itey
            ij=ij+1
            grid%xp%v1y(i,j,k) = work_1d(ij)
         end do

         do n=1, xbx%pad_num
            i=xbx%pad_loc(n)
            ij=ij+1
            grid%xp%v2y(i,j,k) = work_1d(ij)
         end do
      end do
   end do

   !---------------------------------------------------------------------------
   ! Perform inverse FFT in x direction:
   !---------------------------------------------------------------------------

   ! Apply (i',j,k' -> i,j',k') transpose (v1y -> v1x).

   call da_transpose_y2x (grid)
   call da_transpose_y2x_v2 (grid)

   ! Set up FFT parameters:

   idim = xbx%fft_ix
   jdim = grid%xp%jtex - grid%xp%jtsx + 1

   vector_inc  = 1
   vector_jump = idim
   vector_size = idim - 1

   num_vectors = jdim

   work_area   = (vector_size+1)*num_vectors

   ! [2.3] Perform forward FFT:

   do k = grid%xp%ktsx, grid%xp%ktex
      ij = 0
      do j=grid%xp%jtsx, grid%xp%jtex
         do i=ids, ide
            ij=ij+1
            work_1d(ij) = grid%xp%v1x(i,j,k)
         end do

         do n=1, xbx%fft_pad_i
            i=(n-1)*xbx%pad_inc+1
            ij=ij+1
            work_1d(ij) = grid%xp%v2x(i,j,k)
         end do
      end do

      call fft661(Inverse_FFT, vector_inc, vector_jump, &
                                   num_vectors, vector_size, &
                                   xbx % fft_factors_x, xbx % trig_functs_x, &
                                   work_1d(1), work_area)
      ij = 0
      do j=grid%xp%jtsx, grid%xp%jtex
         do i=ids, ide
            ij=ij+1
            grid%xp%v1x(i,j,k) = work_1d(ij)*xbx%fft_adjoint_factor
         end do

         ij=ij+xbx%fft_pad_i
      end do
   end do

   ! Apply (i,j',k') -> i',j',k) transpose to restore v1z.
   
   call da_transpose_x2z (grid)

!STARTOFREGISTRYGENERATEDINCLUDE 'inc/HALO_BAL_EQN_ADJ.inc'
!
! WARNING This file is generated automatically by use_registry
! using the data base in the file named Registry.
! Do not edit.  Your changes to this file will be lost.
!
CALL HALO_BAL_EQN_ADJ_sub ( grid, &
  local_communicator, &
  mytask, ntasks, ntasks_x, ntasks_y, &
  ids, ide, jds, jde, kds, kde,       &
  ims, ime, jms, jme, kms, kme,       &
  ips, ipe, jps, jpe, kps, kpe )
!ENDOFREGISTRYGENERATEDINCLUDE

   ! [2.5] Write data array into del2b:

   del2b(ims:ime,jms:jme,kms:kme) = grid%xp%v1z(ims:ime,jms:jme,kms:kme)

   !---------------------------------------------------------------------------
   ! [5.0] Tidy up:
   !---------------------------------------------------------------------------

   if (allocated(work_1d)) deallocate(work_1d)

   if (trace_use) call da_trace_exit("da_solve_poissoneqn_fst_adj")

end subroutine da_solve_poissoneqn_fst_adj



end module da_ffts
