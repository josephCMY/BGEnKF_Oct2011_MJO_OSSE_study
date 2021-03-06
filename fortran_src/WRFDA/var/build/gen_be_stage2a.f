












program gen_be_stage2a

   use da_control, only : stderr, stdout, filename_len
   use da_gen_be, only : da_filter_regcoeffs
   use da_tools_serial, only : da_get_unit, da_advance_cymdh

   implicit none

   character*10        :: start_date, end_date 
   character*10        :: date, new_date       
   character*10        :: variable             
   character(len=filename_len)        :: filename             
   character*3         :: ce                   
   integer             :: ni, nj, nk, nkdum    
   integer             :: i, j, k, member      
   integer             :: b                    
   integer             :: sdate, cdate, edate  
   integer             :: interval             
   integer             :: ne                   
   integer             :: bin_type             
   integer             :: num_bins             
   integer             :: num_bins2d           
   integer             :: num_passes           
   integer             :: cv_options           
   real                :: lat_min, lat_max     
   real                :: binwidth_lat         
   real                :: hgt_min, hgt_max     
   real                :: binwidth_hgt         
   real                :: rf_scale             

   real, allocatable   :: psi(:,:,:)           
   real, allocatable   :: chi(:,:,:)           
   real, allocatable   :: temp(:,:,:)          
   real, allocatable   :: ps(:,:)              
   integer, allocatable:: bin(:,:,:)           
   integer, allocatable:: bin2d(:,:)           

   real, allocatable   :: regcoeff1(:)         
   real, allocatable   :: regcoeff2(:,:)       
   real, allocatable   :: regcoeff3(:,:,:)     

   namelist / gen_be_stage2a_nl / start_date, end_date, interval, &
                                  ne, num_passes, rf_scale, cv_options

   integer :: ounit,iunit,namelist_unit

   stderr = 0
   stdout = 6


   write(6,'(a)')' [1] Initialize namelist variables and other scalars.'


   call da_get_unit(ounit)
   call da_get_unit(iunit)
   call da_get_unit(namelist_unit)

   start_date = '2004030312'
   end_date = '2004033112'
   interval = 24
   ne = 1
   num_passes = 0
   rf_scale = 1.0
   cv_options = 5

   open(unit=namelist_unit, file='gen_be_stage2a_nl.nl', &
        form='formatted', status='old', action='read')
   read(namelist_unit, gen_be_stage2a_nl)
   close(namelist_unit)

   read(start_date(1:10), fmt='(i10)')sdate
   read(end_date(1:10), fmt='(i10)')edate
   write(6,'(4a)')' Computing control variable fields'
   write(6,'(4a)') ' Time period is ', start_date, ' to ', end_date
   write(6,'(a,i8,a)')' Interval between dates = ', interval, 'hours.'
   write(6,'(a,i8)')' Number of ensemble members at each time = ', ne

   date = start_date
   cdate = sdate


   write(6,'(2a)')' [2] Read regression coefficients and bin information:'


   filename = 'gen_be_stage2.dat'
   open (iunit, file = filename, form='unformatted')
   read(iunit)ni, nj, nk
   read(iunit)num_bins, num_bins2d

   allocate( bin(1:ni,1:nj,1:nk) )
   allocate( bin2d(1:ni,1:nj) )
   allocate( psi(1:ni,1:nj,1:nk) )
   allocate( chi(1:ni,1:nj,1:nk) )
   allocate( temp(1:ni,1:nj,1:nk) )
   allocate( ps(1:ni,1:nj) )
   allocate( regcoeff1(1:num_bins) )
   allocate( regcoeff2(1:nk,1:num_bins2d) )
   allocate( regcoeff3(1:nk,1:nk,1:num_bins2d) )

   read(iunit)regcoeff1
   read(iunit)regcoeff2
   read(iunit)regcoeff3
   close(iunit)


   filename = 'bin.data'
   open (iunit, file = filename, form='unformatted')
   read(iunit)bin_type
   read(iunit)lat_min, lat_max, binwidth_lat
   read(iunit)hgt_min, hgt_max, binwidth_hgt
   read(iunit)num_bins, num_bins2d
   read(iunit)bin(1:ni,1:nj,1:nk)
   read(iunit)bin2d(1:ni,1:nj)
   close(iunit)

   if ( num_passes > 0 ) then


      write(6,'(a,i4,a)')' [3] Apply ', num_passes, ' pass recursive filter to regression coefficients:'

      call da_filter_regcoeffs( ni, nj, nk, num_bins, num_bins2d, num_passes, rf_scale, bin, &
                                regcoeff1, regcoeff2, regcoeff3 )
   else
      write(6,'(a)')' [3] num_passes = 0. Bypassing recursive filtering.'
   end if


   write(6,'(a)')' [4] Read standard fields, and compute control variable fields:'


   date = start_date
   cdate = sdate

   do while ( cdate <= edate )
      write(6,'(a,a)')'    Calculating unbalanced fields for date ', date

      do member = 1, ne

         write(ce,'(i3.3)')member


         variable = 'psi'
         filename = trim(variable)//'/'//date(1:10)
         filename = trim(filename)//'.'//trim(variable)//'.e'//ce
         open (iunit, file = filename, form='unformatted')
         read(iunit)ni, nj, nk
         read(iunit)psi
         close(iunit)


         variable = 'chi'
         filename = trim(variable)//'/'//date(1:10)
         filename = trim(filename)//'.'//trim(variable)//'.e'//ce
         open (iunit, file = filename, form='unformatted')
         read(iunit)ni, nj, nk
         read(iunit)chi
         close(iunit)

         if ( cv_options /= 7 ) then
            do k = 1, nk
               do j = 1, nj
                  do i = 1, ni
                     b = bin(i,j,k)
                     chi(i,j,k) = chi(i,j,k) - regcoeff1(b) * psi(i,j,k)
                  end do
               end do
            end do
         end if

         variable = 'chi_u'
         filename = trim(variable)//'/'//date(1:10)
         filename = trim(filename)//'.'//trim(variable)//'.e'//ce
         open (ounit, file = filename, form='unformatted')
         write(ounit)ni, nj, nk
         write(ounit)chi
         close(ounit)


         variable = 't'
         filename = trim(variable)//'/'//date(1:10)
         filename = trim(filename)//'.'//trim(variable)//'.e'//ce
         open (iunit, file = filename, form='unformatted')
         read(iunit)ni, nj, nk
         read(iunit)temp
         close(iunit)

         if ( cv_options /= 7 ) then
            do j = 1, nj
               do i = 1, ni
                  b = bin2d(i,j)
                  do k = 1, nk
                     temp(i,j,k) = temp(i,j,k) - SUM(regcoeff3(k,1:nk,b) * psi(i,j,1:nk))
                  end do
               end do
            end do
         end if

         variable = 't_u'
         filename = trim(variable)//'/'//date(1:10)
         filename = trim(filename)//'.'//trim(variable)//'.e'//ce
         open (ounit, file = filename, form='unformatted')
         write(ounit)ni, nj, nk
         write(ounit)temp
         close(ounit)


         variable = 'ps'
         filename = trim(variable)//'/'//date(1:10)
         filename = trim(filename)//'.'//trim(variable)//'.e'//ce//'.01'
         open (iunit, file = filename, form='unformatted')
         read(iunit)ni, nj, nkdum
         read(iunit)ps
         close(iunit)

         if ( cv_options /= 7 ) then
            do j = 1, nj
               do i = 1, ni
                  b = bin2d(i,j)
                  ps(i,j) = ps(i,j) - SUM(regcoeff2(1:nk,b) * psi(i,j,1:nk))
               end do
            end do
         end if

         variable = 'ps_u'
         filename = trim(variable)//'/'//date(1:10)
         filename = trim(filename)//'.'//trim(variable)//'.e'//ce//'.01'
         open (ounit, file = filename, form='unformatted')
         write(ounit)ni, nj, 1
         write(ounit)ps
         close(ounit)

      end do  


      call da_advance_cymdh( date, interval, new_date )
      date = new_date
      read(date(1:10), fmt='(i10)')cdate
   end do     

end program gen_be_stage2a

