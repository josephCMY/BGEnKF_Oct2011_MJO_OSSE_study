












program gen_be_ensrf











   use da_control, only : stdout,stderr,filename_len
   use da_gen_be, only : da_stage0_initialize, da_get_field, da_get_trh

   implicit none

   type info_type
       character*40   :: id
       character*40   :: platform
       integer        :: plat
       integer        :: variable
   end type info_type

   type loc_type
       real           :: x
       real           :: y
       real           :: z
   end type loc_type

   type ob_type
      type (info_type):: info
      type (loc_type) :: loc
      real            :: yo
      real            :: omb_mean
      real            :: oma_mean
      real            :: omb_rms
      real            :: oma_rms
      real            :: sigma_o
      real            :: sigma_b
   end type ob_type

   integer, parameter    :: nv3d = 4                  
   integer, parameter    :: nv2d = 1                  
   integer, parameter    :: unit = 100                

   character (len=filename_len)   :: filestub                  
   character (len=filename_len)   :: input_file                
   character (len=filename_len)   :: output_file               
   character (len=10)    :: var                       
   character (len=3)     :: ce                        

   integer               :: num_members               
   integer               :: num_obs                   
   integer               :: ni                        
   integer               :: niu                       
   integer               :: nj                        
   integer               :: njv                       
   integer               :: nk                        
   integer               :: nv                        
   integer               :: nij, nijk, nijkv          
   integer               :: o, member, i, j, k, v     
   integer               :: imin, imax, jmin, jmax    
   integer               :: ijkv                      
   integer               :: index                     
   integer               :: xend 
   real                  :: num_members_inv
   real                  :: num_members_inv1
   real                  :: cov_inf_fac               
   real                  :: cov_loc_rad_m             
   real                  :: cov_loc_rad               
   real                  :: ds                        
   real                  :: x1, y1                    
   real                  :: sigma_o2, sigma_b2
   real                  :: sigma_hh_inv
   real                  :: sigma_xh
   real                  :: beta     
   real                  :: o_minus_b                 
   real                  :: kalman_gain
   real                  :: x_mean
   real                  :: h_mean
   real                  :: hb_mean
   real                  :: ha_mean
   real                  :: sum_f, sum_a
   real                  :: hf, ha 

   type (ob_type),pointer:: ob(:)

   character(len=10),allocatable :: varr(:)          
   integer, allocatable  :: nkk(:)              
   integer, allocatable  :: xstart(:)           

   real, allocatable     :: x(:,:), xf(:,:)
   
   real, allocatable     :: h(:), h_devn(:)
   real, allocatable     :: x_devn(:)

   real, allocatable     :: uc(:,:)                   
   real, allocatable     :: vc(:,:)                   
   real, allocatable     :: field(:,:)                
   real, allocatable     :: dummy(:,:)                
   real, allocatable     :: corr(:,:)                 
   real, allocatable     :: xf_mean(:)                
   real, allocatable     :: xa_mean(:)                
 
   namelist / gen_be_ensrf_nl / filestub, num_members, &
                                cov_inf_fac, cov_loc_rad_m

   stderr = 0
   stdout = 6


   write(6,'(/a)')' [1] Initialize information.'


   filestub = 'test'
   num_members = 56
   cov_inf_fac = 1.0
   cov_loc_rad_m = 1500000.0

   open(unit=unit, file='gen_be_ensrf_nl.nl', &
        form='formatted', status='old', action='read')
   read(unit, gen_be_ensrf_nl)
   close(unit)

   write(6,'(a,a)')'   Filestub = ', trim(filestub)
   write(6,'(a,i4)')'   Number of ensemble members = ', num_members
   write(6,'(a,f16.8)')'   Covariance Inflation Factor = ', cov_inf_fac
   write(6,'(a,f16.8)')'   Covariance Localization Radius (m) = ', cov_loc_rad_m

   num_members_inv = 1.0 / real(num_members)
   num_members_inv1 = 1.0 / real(num_members-1)


   write(6,'(/a)')' [2] Set up data dimensions and allocate arrays:' 



   input_file = trim(filestub)//'.e001'
   var = 'T'
   call da_stage0_initialize( input_file, var, ni, nj, nk, ds )
   niu = ni+1 
   njv = nj+1 
   cov_loc_rad = cov_loc_rad_m / ds
   nij = ni * nj
   nijk = nij * nk
   nijkv = nv3d * nijk + nv2d * nij 
   nv = nv3d + nv2d
print *, ni, nj, nk, nv, nij, nijk, nv3d, nv2d, nijkv

   allocate ( varr(1:nv) )
   allocate ( nkk(1:nv) )
   allocate ( xstart(1:nv) )
   allocate( x(1:nijkv,1:num_members) )
   allocate( xf(1:nijkv,1:num_members) )
   
   allocate( h(1:num_members) )
   allocate( h_devn(1:num_members) )
   allocate( x_devn(1:num_members) )
   do v = 1, nv3d
      nkk(v) = nk
   end do
   do v = nv3d + 1, nv
      nkk(v) = 1 
   end do
   allocate( field(1:ni,1:nj) )
   allocate( uc(1:niu,1:nj) )
   allocate( vc(1:ni,1:njv) )
   allocate( dummy(1:ni,1:nj) )
   allocate( corr(1:ni,1:nj) )


   varr(1) = 'U'
   varr(2) = 'V'
   varr(3) = 'T'
   varr(4) = 'QVAPOR'
   varr(5) = 'PSFC'


   write(6,'(/a)')' [3] Read observations.'


   input_file = 'observations'
   open(unit, file = input_file, status='old')




   read(unit,*)num_obs
   write(6,'(a,i10)')'   Number of observations = ', num_obs
   allocate( ob(1:num_obs) )

   do o = 1, num_obs
      read(unit,'(2a10,i6,5f16.8)')ob(o) % info % id, ob(o) % info % platform, &
                ob(o) % info % variable, &
                ob(o) % loc % x, ob(o) % loc % y ,ob(o) % loc % z, &
                ob(o) % yo, ob(o) % sigma_o
   end do


   write(6,'(/a)')' [4] Extract necessary fields from WRF ensemble forecasts.'


   xstart(1) = 1
   do v = 2, nv
      xstart(v) = xstart(v-1) + ( ni * nj * nkk(v-1) )
   end do

   do member = 1, num_members

      write(UNIT=ce,FMT='(i3.3)')member
      input_file = trim(filestub)//'.e'//ce  

      do v = 1, nv
         do k = 1, nkk(v)

            if ( varr(v) == 'U' ) then
               call da_get_field( input_file, varr(v), 3, niu, nj, nk, k, uc )
               do j = 1, nj
                  do i = 1, ni
                     field(i,j) = 0.5 * ( uc(i,j) + uc(i+1,j) )
                  end do
               end do
            end if

            if ( varr(v) == 'V' ) then
               call da_get_field( input_file, varr(v), 3, ni, njv, nk, k, vc )
               do j = 1, nj
                  do i = 1, ni
                     field(i,j) = 0.5 * ( vc(i,j) + vc(i,j+1) )
                  end do
               end do
            end if

            if ( varr(v) == "T" ) then

               call da_get_trh( input_file, ni, nj, nk, k, field, dummy )
            end if


            if ( varr(v) == 'QVAPOR' ) then
               call da_get_field( input_file, varr(v), 3, ni, nj, nk, k, field )
               field(:,:) = field(:,:) / ( 1.0 + field(:,:) )
            end if


            if ( varr(v) == 'PSFC' ) then
               call da_get_field( input_file, varr(v), 2, ni, nj, nk, k, field )
            end if


            index = xstart(v) + (k-1) * nij
            do j = 1, nj
               do i = 1, ni
                  xf(index,member) = field(i,j)
                  index = index + 1
               end do
            end do
         end do 
      end do 
   end do 


   x(1:nijkv,1:num_members) = xf(1:nijkv,1:num_members)


   call da_cov_inflation( nijkv, num_members, cov_inf_fac, x )


   deallocate( uc )
   deallocate( vc )
   deallocate( field )
   deallocate( dummy )


   write(6,'(/a)')' [5] Perform EnSRF:'


   do o = 1, num_obs 
      write(6,'(2(a,i8))')'     Assimilating observation ', o, ' of ', num_obs
      x1 = ob(o) % loc % x 
      y1 = ob(o) % loc % y 
      sigma_o2 = ob(o) % sigma_o * ob(o) % sigma_o



      do member = 1, num_members
         call da_obs_operator( nv, ni, nj, nkk, xstart, ob(o), x(:,member), h(member) )
      end do


      h_mean = sum(h(1:num_members)) * num_members_inv
      h_devn(1:num_members) = h(1:num_members) - h_mean


      sigma_b2 = sum(h_devn(1:num_members) * h_devn(1:num_members)) * num_members_inv1

      ob(o) % sigma_b = sqrt(sigma_b2)


      sigma_hh_inv = 1.0 / ( sigma_b2 + sigma_o2 )


      beta = 1.0 / ( 1.0 + sqrt( sigma_o2 * sigma_hh_inv ) )






      o_minus_b = ob(o) % yo - h_mean
      write(6,'(a,2f15.5)')' Observation increment = ', o_minus_b
      write(6,'(a,2f15.5)')' Observation/forecast error variance = ', sigma_o2, sigma_b2





      imin = max(nint(ob(o) % loc % x - cov_loc_rad),1)
      imax = min(nint(ob(o) % loc % x + cov_loc_rad),ni)
      jmin = max(nint(ob(o) % loc % y - cov_loc_rad),1)
      jmax = min(nint(ob(o) % loc % y + cov_loc_rad),nj)




      do j = jmin, jmax
         do i = imin, imax
            call compact_support( x1, real(i), y1, real(j), cov_loc_rad, corr(i,j) )
         end do
      end do

      do v = 1, nv
         do k = 1, nkk(v)
            do j = jmin, jmax
               do i = imin, imax
                  ijkv = (v-1) * nijk + (k-1) * nij + (j-1) * ni + i

                  x_mean = sum(x(ijkv,1:num_members)) * num_members_inv

                  x_devn(1:num_members) = x(ijkv,1:num_members) - x_mean


                  sigma_xh = sum( x_devn(1:num_members) * h_devn(1:num_members) ) * &
                             num_members_inv1


                  sigma_xh = sigma_xh * corr(i,j)

                  kalman_gain = sigma_xh * sigma_hh_inv

                  x_mean = x_mean + kalman_gain * o_minus_b

                  x_devn(1:num_members) = x_devn(1:num_members) - &
                                          beta * kalman_gain * h_devn(1:num_members)

                  x(ijkv,1:num_members) = x_mean + x_devn(1:num_members)

               end do
            end do 
         end do
      end do
   end do


   write(6,'(/a)')' [4] Calculate diagnostics:' 




   allocate( xf_mean(1:nijkv) )
   allocate( xa_mean(1:nijkv) )

   do ijkv = 1, nijkv
      xf_mean(ijkv) = sum(xf(ijkv,1:num_members)) * num_members_inv
      xa_mean(ijkv) = sum(x(ijkv,1:num_members)) * num_members_inv
   end do




   call da_get_grid_stats( num_members, ni, nj, nk, nv, nijkv, nkk, varr, xf, x )



   write(53,*)num_obs
   do o = 1, num_obs


      call da_obs_operator( nv, ni, nj, nkk, xstart, ob(o), xf_mean, hb_mean )
      call da_obs_operator( nv, ni, nj, nkk, xstart, ob(o), xa_mean, ha_mean )

      ob(o) % omb_mean = ob(o) % yo - hb_mean
      ob(o) % oma_mean = ob(o) % yo - ha_mean


      sum_f = 0.0
      sum_a = 0.0
      do member = 1, num_members

         call da_obs_operator( nv, ni, nj, nkk, xstart, ob(o), xf(:,member), hf )
         call da_obs_operator( nv, ni, nj, nkk, xstart, ob(o), x(:,member), ha )
         sum_f = sum_f + ( ob(o) % yo - hf )**2
         sum_a = sum_a + ( ob(o) % yo - ha )**2
      end do

      ob(o) % omb_rms = sqrt( sum_f * num_members_inv )
      ob(o) % oma_rms = sqrt( sum_a * num_members_inv )

      write(53,'(2a10,i8,10f16.8)')ob(o) % info % id, ob(o) % info % platform, &
                ob(o) % info % variable, &
                ob(o) % loc % x, ob(o) % loc % y ,ob(o) % loc % z, &
                ob(o) % yo, ob(o) % omb_mean, ob(o) % oma_mean, &
                ob(o) % omb_rms, ob(o) % oma_rms, &
                ob(o) % sigma_o, ob(o) % sigma_b
   end do


   write(6,'(/a)')' [4] Output EnSRF analysis ensemble:'


   do member = 1, num_members
      write(6,'(a,i4)')'   Writing ensemble member increments for member', member
      write(UNIT=ce,FMT='(i3.3)')member

      do v = 1, nv


         output_file = trim(varr(v))//'/'//trim(varr(v))//'.prior.e'//trim(ce)
         open(unit, file = output_file, form='unformatted')
         write(unit)ni, nj, nkk(v)
         xend = xstart(v) + nij * nkk(v) - 1
         write(unit)xf(xstart(v):xend,member)
         close(unit)


         output_file = trim(varr(v))//'/'//trim(varr(v))//'.posterior.e'//trim(ce)
         open(unit, file = output_file, form='unformatted')
         write(unit)ni, nj, nkk(v)
         xend = xstart(v) + nij * nkk(v) - 1
         write(unit)x(xstart(v):xend,member)
         close(unit)
      end do
   end do

   do v = 1, nv


      output_file = trim(varr(v))//'/'//trim(varr(v))//'.prior.mean'
      open(unit, file = output_file, form='unformatted')
      write(unit)ni, nj, nkk(v)
      xend = xstart(v) + nij * nkk(v) - 1
      write(unit)xf_mean(xstart(v):xend)
      close(unit)


      output_file = trim(varr(v))//'/'//trim(varr(v))//'.posterior.mean'
      open(unit, file = output_file, form='unformatted')
      write(unit)ni, nj, nkk(v)
      xend = xstart(v) + nij * nkk(v) - 1
      write(unit)xa_mean(xstart(v):xend)
      close(unit)
   end do

   deallocate( ob )

contains



subroutine da_obs_operator( nv, ni, nj, nkk, xstart, ob, x, h )

   implicit none

   integer, intent(in)              :: nv, ni, nj
   integer, intent(in)              :: nkk(1:nv)
   integer, intent(in)              :: xstart(1:nv)
   type (ob_type), intent(in)       :: ob
   
   
   real, intent(in)                 :: x(:)
   real, intent(out)                :: h

   integer                          :: v, nk
   integer                          :: start
   real                             :: ob_x, ob_y, ob_z 

   v = ob % info % variable
   nk = nkk(v)
   start = xstart( v )



   ob_x = ob % loc % x
   ob_y = ob % loc % y
   ob_z = ob % loc % z

   call da_interpolate_3d( ni, nj, nk, ob % loc % x, ob % loc % y, ob % loc % z, &
                           x(start:start + ni * nj * nk ), h )

end subroutine da_obs_operator

subroutine da_interpolate_3d( ni, nj, nk, x, y, z, field, h )

   implicit none
   integer, intent(in)   :: ni, nj, nk
   real, intent(in)      :: x, y, z      
   real, intent(in)      :: field(1:ni,1:nj,1:nk) 
   real, intent(out)     :: h            

   integer               :: ii, jj, kk   
   real                  :: dx, dy, dz   
   real                  :: h1, h2       
   real                  :: h_below      
   real                  :: h_above      

   ii = int(x)
   jj = int(y)
   kk = int(z)

   dx = x - real(ii)
   dy = y - real(jj)
   dz = z - real(kk)


   h1 = ( 1.0 - dx ) * field(ii,jj,kk)   + dx * field(ii+1,jj,kk)
   h2 = ( 1.0 - dx ) * field(ii,jj+1,kk) + dx * field(ii+1,jj+1,kk)
   h_below = ( 1.0 - dy ) * h1 + dy * h2


   h1 = ( 1.0 - dx ) * field(ii,jj,kk+1)   + dx * field(ii+1,jj,kk+1)
   h2 = ( 1.0 - dx ) * field(ii,jj+1,kk+1) + dx * field(ii+1,jj+1,kk+1)
   h_above = ( 1.0 - dy ) * h1 + dy * h2


   h = ( 1.0 - dz ) * h_below + dz * h_above

end subroutine da_interpolate_3d

subroutine compact_support( x1, x2, y1, y2, cov_loc_rad, corr )





   implicit none

   real, intent(in)     :: x1, x2         
   real, intent(in)     :: y1, y2         
   real, intent(in)     :: cov_loc_rad    
   real, intent(out)    :: corr           

   real                 :: z              
   real                 :: r              
   real                 :: r2, r3, r4, r5 

   z = sqrt( ( x2 - x1 )**2 + ( y2 - y1)**2 )
   r = z / cov_loc_rad

   r2 = r * r
   r3 = r2 * r
   r4 = r3 * r
   r5 = r4 * r

   if ( r <= 1.0 ) then
      corr = -0.25 * r5 + 0.5 * r4 + 0.625 * r3 - 5.0 * r2 / 3.0 + 1
   else if ( r > 1.0 .and. r < 2.0 ) then
      corr = r5 / 12.0 - 0.5 * r4 + 0.625 * r3 + 5.0 * r2 / 3.0 - &
             5.0 * r + 4.0 - 2.0 / ( 3.0 * r )

   else if ( r >= 2.0 ) then
      corr = 0.0
   end if

end subroutine compact_support

subroutine da_get_grid_stats( num_members, ni, nj, nk, nv, nijkv, nkk, varr, xf, xa )

   implicit none

   integer, intent(in)   :: num_members
   integer, intent(in)   :: ni
   integer, intent(in)   :: nj
   integer, intent(in)   :: nk
   integer, intent(in)   :: nv
   integer, intent(in)   :: nijkv
   integer, intent(in)   :: nkk(1:nv)
   character*10,intent(in):: varr(1:nv)
   real, intent(in)      :: xf(1:nijkv,1:num_members)
   real, intent(in)      :: xa(1:nijkv,1:num_members)

   character*10          :: name
   integer               :: v, k, j, i, ijkv
   real                  :: num_members_inv, nij_inv
   real                  :: mnsq_f, mnsq_a
   real                  :: domain_mean_f, domain_mean_a
   real                  :: domain_stdv_f, domain_stdv_a
   real                  :: mean_f(1:ni,1:nj), mean_a(1:ni,1:nj)
   real                  :: stdv_f(1:ni,1:nj), stdv_a(1:ni,1:nj)

   num_members_inv = 1.0 / num_members
   nij_inv = 1.0 / real ( ni * nj )

   write(6,'(a)')' Variable, Level,   Mean_F,   Mean_A,   StDv_F,   StdV_A'

   ijkv = 0
   do v = 1, nv
      name = varr(v)
      do k = 1, nkk(v)
         do j = 1, nj
            do i = 1, ni
               ijkv = ijkv + 1
               mean_f(i,j) = sum(xf(ijkv,1:num_members)) * num_members_inv
               mean_a(i,j) = sum(xa(ijkv,1:num_members)) * num_members_inv
               mnsq_f      = sum(xf(ijkv,1:num_members)**2) * num_members_inv
               mnsq_a      = sum(xa(ijkv,1:num_members)**2) * num_members_inv
               stdv_f(i,j) = mnsq_f - mean_f(i,j) * mean_f(i,j)
               stdv_a(i,j) = mnsq_a - mean_a(i,j) * mean_a(i,j)
               stdv_f(i,j) = 0.0
               if ( stdv_f(i,j) > 0.0 ) stdv_f(i,j) = sqrt(stdv_f(i,j))
               stdv_a(i,j) = 0.0
               if ( stdv_a(i,j) > 0.0 ) stdv_a(i,j) = sqrt(stdv_a(i,j))
            end do
         end do

         domain_mean_f = sum(mean_f(:,:)) * nij_inv
         domain_mean_a = sum(mean_a(:,:)) * nij_inv
         domain_stdv_f = sum(stdv_f(:,:)) * nij_inv
         domain_stdv_a = sum(stdv_a(:,:)) * nij_inv

         write(6,'(a,i6,4f16.8)')trim(name), k, domain_mean_f, domain_mean_a, &
                                 domain_stdv_f, domain_stdv_a
      end do
   end do

end subroutine da_get_grid_stats

subroutine da_cov_inflation( nijkv, num_members, cov_inf_fac, x )

   implicit none

   integer, intent(in) :: nijkv
   integer, intent(in) :: num_members
   real, intent(in)    :: cov_inf_fac
   real, intent(inout) :: x(1:nijkv,1:num_members)

   integer             :: ijkv
   real                :: num_members_inv
   real                :: x_devn(1:num_members)

   num_members_inv = 1.0 / real(num_members)

   do ijkv = 1, nijkv
      x_mean = sum(x(ijkv,1:num_members)) * num_members_inv
      x_devn(1:num_members) = cov_inf_fac * ( x(ijkv,1:num_members) - x_mean )
      x(ijkv,1:num_members) = x_mean + x_devn(1:num_members)
   end do

end subroutine da_cov_inflation

end program gen_be_ensrf

