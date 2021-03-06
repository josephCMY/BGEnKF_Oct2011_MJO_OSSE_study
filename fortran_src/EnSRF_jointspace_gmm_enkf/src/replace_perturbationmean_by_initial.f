!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  program replace

! 1, in shell script (out of this program), copy gfs_initial file to each output members (fort.900??);
! 2, link gfs_initial as fort.70010; and link ensemble members perturbed by 3dvar as fort.800??;
! 3, for each variable, 
!    -- calculate the average of perturbation xm, and perturbation xa=xa-xm;
!    -- replace xm by gfs initial xm=gfs;
!    -- calculate new variable value: xa=xm+xa; 
!    -- output to fort.900??.
  
!----------------------------------------------------------------
  use netcdf
  implicit none

  integer            :: i_unit=80010, o_unit=90010, gfs_unit=70010
  integer            :: unit
  integer            :: numbers_en 
  integer            :: ix, jx, kx, kxs, i, j, k, len 
  integer            :: ii, jj, kk, m, n, fid, iargc
  character (len=10) :: wrf_file, filec
  character (len=4)  :: numbers_enc

!----------------------------------------------------------------
! variables will be replaced
  character (len=10), allocatable, dimension(:) :: varname
  integer                                       :: varnum
  character (len=10)                            :: var

  real, allocatable, dimension(:,:,:,:) :: xa      !!! ensemble members
  real, allocatable, dimension(:,:,:)   :: xm      !!! ensemble mean
  real, allocatable, dimension(:,:,:)   :: gfs     !!! initial field
  real, allocatable, dimension(:,:,:)   :: dat3d, work

!----------------------------------------------------------------
! variables will be replaced
  varnum = 23
  allocate( varname (varnum) )
!----------------------------------------------------------------

! Get ensemble number
  if (iargc() .lt. 1) then
     write(6,*) ' usage: replace_perturbationmean_by_initial ensember_number '
     stop
  else
     call getarg(1, numbers_enc)
     read(numbers_enc,'(i)')numbers_en
  endif 

  write(*,*)'numbers_en =', numbers_en

  varname = (/'U         ', 'V         ', 'W         ', 'PH        ', 'PHB       ', &
              'T         ', 'MU        ', 'MUB       ', 'P         ', 'PB        ',  &
              'Q2        ', 'T2        ', 'TH2       ', 'PSFC      ', &
              'U10       ', 'V10       ', 'QVAPOR    ', 'QCLOUD    ', 'QRAIN     ', &
              'QICE      ', 'QSNOW     ', 'QGRAUP    ', 'TSK       '/)

!----------------------------------------------------------------
! Get WRF model dimension from the 1th member
!  call get_var_ij ( 'fort.70010', 'T         ', ix, jx, kx )
  call get_ij ( 'fort.70010', ix, jx, kx, kxs )
  write(*,*)'wrf dimension: ', ix, jx, kx

!----------------------------------------------------------------
  do_wrf_var  : do m = 1, varnum

!.... get dimensions
      var = varname(m)
      write(*,*)var
      call wrf_var_dimension ( var, ix, jx, kx, kxs, ii, jj, kk )
      allocate( xa    ( ii, jj, kk, numbers_en ) )
      allocate( xm    ( ii, jj, kk ) )
      allocate( gfs   ( ii, jj, kk ) )
      allocate( dat3d ( ii, jj, kk ) )
      allocate( work  ( ii, jj, kk ) )

!.... get gfs initial 
      if ( kk > 1 ) then
         call get_variable3d( 'fort.70010', var, ii, jj, kk, 1, gfs )
      else if ( kk == 1 ) then
         call get_variable2d( 'fort.70010', var, ii, jj, 1, gfs )
      endif

!.... get ensemble and calculate average
      work = 0.
      do_ensemble_member : do n = 1, numbers_en
         write(wrf_file,'(a5,i5.5)')'fort.',i_unit+n
!....... get data and sum
         if ( kk > 1 ) then
            call get_variable3d( wrf_file, var, ii, jj, kk, 1, dat3d )
         else if ( kk == 1 ) then
            call get_variable2d( wrf_file, var, ii, jj, 1, dat3d )
         endif
         xa(:,:,:,n)=dat3d(:,:,:)
         work = work + dat3d
      end do do_ensemble_member
      xm = work/float(numbers_en)

!.... replace xm by gfs
!.... output to ensemble
      do n = 1, numbers_en
         write(wrf_file,'(a5,i5.5)')'fort.',o_unit+n
         write(*,*)'output to ', wrf_file
         call open_file( wrf_file, nf_write, fid )

         work(:,:,:)=xa(:,:,:,n)-xm(:,:,:)+gfs(:,:,:)
         if ( kk > 1 ) then
            call write_variable3d(fid, var, ii, jj, kk, 1, work )
         else if ( kk == 1 ) then
            call write_variable2d(fid, var, ii, jj,  1, work )
         endif
         call close_file( fid )
      enddo 

      deallocate( xa    )
      deallocate( xm    )
      deallocate( gfs   )
      deallocate( dat3d )
      deallocate( work  )

  end do do_wrf_var

end program replace

!==============================================================================
subroutine wrf_var_dimension ( var, ix, jx, kx, kxs, ii, jj, kk )

   character(len=10), intent(in)   :: var
   integer, intent(in)             :: ix, jx, kx, kxs
   integer, intent(out)            :: ii, jj, kk

   ii = ix
   jj = jx
   kk = kx
   if      ( var == 'U         ' ) then
      ii = ix + 1
   else if ( var == 'V         ' ) then
      jj = jx + 1
   else if ( var == 'W         ' .or. var == 'PH        ' .or. var == 'PHB       ' ) then
      kk = kx + 1
   else if ( var == 'MU        ' .or. var == 'MUB       ' .or. var == 'Q2        '  &
        .or. var == 'T2        ' .or. var == 'TH2       ' .or. var == 'PSFC      '  &
        .or. var == 'SST       ' .or. var == 'TSK       ' .or. var == 'XICE      '  &
        .or. var == 'SFROFF    ' .or. var == 'UDROFF    ' .or. var == 'IVGTYP    '  &
        .or. var == 'ISLTYP    ' .or. var == 'VEGFRA    ' .or. var == 'GRDFLX    '  &
        .or. var == 'SNOW      ' .or. var == 'SNOWH     ' .or. var == 'CANWAT    '  &
        .or. var == 'SST       ' .or. var == 'MAPFAC_M  ' .or. var == 'F         '  &
        .or. var == 'E         ' .or. var == 'SINALPHA  ' .or. var == 'COSALPHA  '  &
        .or. var == 'HGT       ' .or. var == 'TSK       ' .or. var == 'RAINC     '  &
        .or. var == 'RAINNC    ' .or. var == 'SWDOWN    ' .or. var == 'GLW       '  &
        .or. var == 'XLAT      ' .or. var == 'XLONG     ' .or. var == 'TMN       '  &
        .or. var == 'XLAND     ' .or. var == 'PBLH      ' .or. var == 'HFX       '  &
        .or. var == 'QFX       ' .or. var == 'LH        ' .or. var == 'SNOWC     '  &
        .or. var == 'SR        ' .or. var == 'POTEVP    ' .or. var == 'U10       '  &
        .or. var == 'V10       ' .or. var == 'MU0       ' ) then
      kk = 1
   else if ( var == 'MAPFAC_U  ' ) then
      kk = 1
      ii = ix + 1
   else if ( var == 'MAPFAC_V  ' ) then
      kk = 1
      jj = jx + 1
   else if ( var == 'FNM       ' .or. var == 'FNP       '  &
        .or. var == 'RDNW      ' .or. var == 'RDN       '  &
        .or. var == 'DNW       ' .or. var == 'DN        '  &
        .or. var == 'ZNU       '                          ) then
      ii = 1
      jj = 1
   else if ( var == 'ZNW       '                          ) then
      ii = 1
      jj = 1
      kk = kx + 1
   endif

   if( var == 'TSLB' .or. var == 'SMOIS' ) then
      kk = kxs
   end if

end subroutine wrf_var_dimension

!==============================================================================
