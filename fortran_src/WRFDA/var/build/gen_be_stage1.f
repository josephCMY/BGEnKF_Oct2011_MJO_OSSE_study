












program gen_be_stage1











   use da_control, only : stderr, stdout, filename_len
   use da_tools_serial, only : da_get_unit,da_advance_cymdh
   use da_gen_be, only : da_create_bins

   implicit none

   character*10        :: start_date, end_date       
   character*10        :: date, new_date             
   character*10        :: variable                   
   character*3         :: be_method                  
   character*3         :: ce                         
   character(len=filename_len)        :: dat_dir                    
   character(len=filename_len)        :: filename                   
   integer             :: count                      
   integer             :: ni, nj, nk                 
   integer             :: member                     
   integer             :: sdate, cdate, edate        
   integer             :: interval                   
   integer             :: ne                         
   integer             :: bin_type                   
   integer             :: num_bins                   
   integer             :: num_bins2d                 
   integer             :: cv_options                 
   real                :: count_inv                  
   real                :: lat_min, lat_max           
   real                :: binwidth_lat               
   real                :: hgt_min, hgt_max           
   real                :: binwidth_hgt               

   real, allocatable   :: ps_prime(:,:)              
   real, allocatable   :: t_prime(:,:,:)             
   real, allocatable   :: psi_prime(:,:,:)           
   real, allocatable   :: chi_prime(:,:,:)           
   real, allocatable   :: u_prime(:,:,:)             
   real, allocatable   :: v_prime(:,:,:)             
   real, allocatable   :: rh_prime(:,:,:)            
   real, allocatable   :: height(:,:,:)              
   real, allocatable   :: latitude(:,:)              
   integer, allocatable:: bin(:,:,:)                 
   integer, allocatable:: bin2d(:,:)                 
   real, allocatable   :: psi_mean(:,:,:)            
   real, allocatable   :: chi_mean(:,:,:)            
   real, allocatable   :: u_mean(:,:,:)              
   real, allocatable   :: v_mean(:,:,:)              
   real, allocatable   :: t_mean(:,:,:)              
   real, allocatable   :: rh_mean(:,:,:)             
   real, allocatable   :: ps_mean(:,:)               

   namelist / gen_be_stage1_nl / start_date, end_date, interval, &
                                 be_method, ne, bin_type, cv_options, &
                                 lat_min, lat_max, binwidth_lat, &
                                 hgt_min, hgt_max, binwidth_hgt, dat_dir

   integer :: ounit,iunit,namelist_unit

   stderr = 0
   stdout = 6

   write(unit=stdout,fmt='(a)') &
      ' [1] Initialize namelist variables and other scalars.'

   call da_get_unit(ounit)
   call da_get_unit(iunit)
   call da_get_unit(namelist_unit)

   start_date = '2004030312'
   end_date = '2004033112'
   interval = 24
   be_method = 'NMC'
   ne = 1
   bin_type = 5         
   cv_options = 5
   lat_min = -90.0
   lat_max = 90.0
   binwidth_lat = 10.0
   hgt_min = 0.0
   hgt_max = 20000.0
   binwidth_hgt = 1000.0
   dat_dir = '/data2/hcshin/youn/DIFF63'

   open(unit=namelist_unit, file='gen_be_stage1_nl.nl', &
        form='formatted', status='old', action='read')
   read(namelist_unit, gen_be_stage1_nl)
   close(namelist_unit)

   if ( be_method /= "ENS" ) ne = 1

   read(start_date(1:10), fmt='(i10)')sdate
   read(end_date(1:10), fmt='(i10)')edate
   write(6,'(4a)')' Computing statistics for dates ', start_date, ' to ', end_date
   write(6,'(a,i8,a)')' Interval between dates = ', interval, 'hours.'
   write(6,'(a,i8)')' Number of ensemble members at each time = ', ne

   date = start_date
   cdate = sdate
   count = 0


   write(6,'(a)')' [2] Read fields from standard files, and calculate mean fields'


   do while ( cdate <= edate )
      do member = 1, ne
         count = count + 1
         count_inv = 1.0 / real(count)

         write(6,'(a,a)')'    Processing data for date ', date

         if ( be_method == 'NMC' ) then
            filename = trim(dat_dir)//'/pert.'//date(1:10)//'.e001'
         else
            write(UNIT=ce,FMT='(i3.3)')member
            filename = trim(dat_dir)//'/pert.'//date(1:10)//'.e'//trim(ce)
         endif

         open (iunit, file = trim(filename), form='unformatted')
         read(iunit)date, ni, nj, nk

         if ( count == 1 ) then
            write(6,'(a,3i8)')'    i, j, k dimensions are ', ni, nj, nk
            allocate( ps_prime(1:ni,1:nj) )
            allocate( t_prime(1:ni,1:nj,1:nk) )
            if ( cv_options == 7 ) then
               allocate( u_prime(1:ni,1:nj,1:nk) )
               allocate( v_prime(1:ni,1:nj,1:nk) )
               allocate( u_mean(1:ni,1:nj,1:nk) )
               allocate( v_mean(1:ni,1:nj,1:nk) )
               u_mean(:,:,:) = 0.0
               v_mean(:,:,:) = 0.0
            else
               allocate( psi_prime(1:ni,1:nj,1:nk) )
               allocate( chi_prime(1:ni,1:nj,1:nk) )
               allocate( psi_mean(1:ni,1:nj,1:nk) )
               allocate( chi_mean(1:ni,1:nj,1:nk) )
               psi_mean(:,:,:) = 0.0
               chi_mean(:,:,:) = 0.0
            end if
            allocate( rh_prime(1:ni,1:nj,1:nk) )
            allocate( height(1:ni,1:nj,1:nk) )
            allocate( latitude(1:ni,1:nj) )
            allocate( t_mean(1:ni,1:nj,1:nk) )
            allocate( rh_mean(1:ni,1:nj,1:nk) )
            allocate( ps_mean(1:ni,1:nj) )
            allocate( bin(1:ni,1:nj,1:nk) )
            allocate( bin2d(1:ni,1:nj) )
            t_mean(:,:,:) = 0.0
            rh_mean(:,:,:) = 0.0
            ps_mean(:,:) = 0.0

         end if

         if ( cv_options == 7 ) then
            read(iunit)u_prime
            read(iunit)v_prime
         else
            read(iunit)psi_prime
            read(iunit)chi_prime
         end if
         read(iunit)t_prime
         read(iunit)rh_prime
         read(iunit)ps_prime
         read(iunit)height
         read(iunit)latitude
         close(iunit)


         if ( count == 1 ) then
            call da_create_bins( ni, nj, nk, bin_type, num_bins, num_bins2d, bin, bin2d, &
                                 lat_min, lat_max, binwidth_lat, &
                                 hgt_min, hgt_max, binwidth_hgt, latitude, height )
         end if





         if ( cv_options == 7 ) then
            u_mean = ( real( count-1 ) * u_mean + u_prime ) * count_inv
            v_mean = ( real( count-1 ) * v_mean + v_prime ) * count_inv
         else
            psi_mean = ( real( count-1 ) * psi_mean + psi_prime ) * count_inv
            chi_mean = ( real( count-1 ) * chi_mean + chi_prime ) * count_inv
         end if
         t_mean = ( real( count-1 ) * t_mean + t_prime ) * count_inv
         rh_mean = ( real( count-1 ) * rh_mean + rh_prime ) * count_inv
         ps_mean = ( real( count-1 ) * ps_mean + ps_prime ) * count_inv

      end do  


      call da_advance_cymdh( date, interval, new_date )
      date = new_date
      read(date(1:10), fmt='(i10)')cdate
   end do     


   write(6,'(a)')' [2] Read fields again, and remove time/ensemble/area mean'


   date = start_date
   cdate = sdate

   do while ( cdate <= edate )
      do member = 1, ne

         write(6,'(a,a)')'    Removing mean for date ', date

         if ( be_method == 'NMC' ) then
            filename = trim(dat_dir)//'/pert.'//date(1:10)//'.e001'
         else
            write(UNIT=ce,FMT='(i3.3)')member
            filename = trim(dat_dir)//'/pert.'//date(1:10)//'.e'//trim(ce)
         endif

         open (iunit, file = trim(filename), form='unformatted')
         read(iunit)date, ni, nj, nk
         if ( cv_options == 7 ) then
            read(iunit)u_prime
            read(iunit)v_prime
         else
            read(iunit)psi_prime
            read(iunit)chi_prime
         end if
         read(iunit)t_prime
         read(iunit)rh_prime
         read(iunit)ps_prime
         read(iunit)height
         read(iunit)latitude
         close(iunit)





         if ( cv_options == 7 ) then
            u_prime = u_prime - u_mean
            v_prime = v_prime - v_mean
         else
            psi_prime = psi_prime - psi_mean
            chi_prime = chi_prime - chi_mean
         end if
         t_prime = t_prime - t_mean
         rh_prime = rh_prime - rh_mean
         ps_prime = ps_prime - ps_mean





         write(ce,'(i3.3)')member


         variable = 'fullflds'
         filename = trim(variable)//'/'//date(1:10)
         filename = trim(filename)//'.'//trim(variable)//'.e'//ce
         open (ounit, file = filename, form='unformatted')
         write(ounit)ni, nj, nk
         write(ounit)latitude
         write(ounit)height
         close(ounit)

         if ( cv_options == 7 ) then

            variable = 'u'
            filename = trim(variable)//'/'//date(1:10)
            filename = trim(filename)//'.'//trim(variable)//'.e'//ce
            open (ounit, file = filename, form='unformatted')
            write(ounit)ni, nj, nk
            write(ounit)u_prime
            close(ounit)


            variable = 'v'
            filename = trim(variable)//'/'//date(1:10)
            filename = trim(filename)//'.'//trim(variable)//'.e'//ce
            open (ounit, file = filename, form='unformatted')
            write(ounit)ni, nj, nk
            write(ounit)v_prime
            close(ounit)
         else

            variable = 'psi'
            filename = trim(variable)//'/'//date(1:10)
            filename = trim(filename)//'.'//trim(variable)//'.e'//ce
            open (ounit, file = filename, form='unformatted')
            write(ounit)ni, nj, nk
            write(ounit)psi_prime
            close(ounit)


            variable = 'chi'
            filename = trim(variable)//'/'//date(1:10)
            filename = trim(filename)//'.'//trim(variable)//'.e'//ce
            open (ounit, file = filename, form='unformatted')
            write(ounit)ni, nj, nk
            write(ounit)chi_prime
            close(ounit)
         end if


         variable = 't'
         filename = trim(variable)//'/'//date(1:10)
         filename = trim(filename)//'.'//trim(variable)//'.e'//ce
         open (ounit, file = filename, form='unformatted')
         write(ounit)ni, nj, nk
         write(ounit)t_prime
         close(ounit)


         variable = 'rh'
         filename = trim(variable)//'/'//date(1:10)
         filename = trim(filename)//'.'//trim(variable)//'.e'//ce
         open (ounit, file = filename, form='unformatted')
         write(ounit)ni, nj, nk
         write(ounit)rh_prime
         close(ounit)


         variable = 'ps' 
         filename = trim(variable)//'/'//date(1:10)
         filename = trim(filename)//'.'//trim(variable)//'.e'//ce//'.01'
         open (ounit, file = filename, form='unformatted')
         write(ounit)ni, nj, 1
         write(ounit)ps_prime
         close(ounit)

      end do  


      call da_advance_cymdh( date, interval, new_date )
      date = new_date
      read(date(1:10), fmt='(i10)')cdate
   end do     



   filename = 'bin.data'
   open (ounit, file = filename, form='unformatted')
   write(ounit)bin_type
   write(ounit)lat_min, lat_max, binwidth_lat
   write(ounit)hgt_min, hgt_max, binwidth_hgt
   write(ounit)num_bins, num_bins2d
   write(ounit)bin(1:ni,1:nj,1:nk)
   write(ounit)bin2d(1:ni,1:nj)
   close(ounit)

end program gen_be_stage1
