












program gen_be_stage1_gsi














   use da_control, only : stderr, stdout, filename_len
   use da_tools_serial, only : da_get_unit,da_advance_cymdh
   use da_gen_be, only : da_create_bins
   use aero_mod

   implicit none

   character*10        :: start_date, end_date       
   character*10        :: date, new_date             
   character*3         :: be_method                  
   character*3         :: ce                         
   character(len=filename_len)        :: stage0_gsi_dir                 
   character(len=filename_len)        :: stage1_gsi_dir                 
   character(len=filename_len)        :: filename                   
   integer             :: count                      
   integer             :: ncases                     
   integer             :: ni, nj, nk                 
   integer             :: member                     
   integer             :: sdate, cdate, edate        
   integer             :: interval                   
   integer             :: ne                         
   real                :: count_inv                  
   real                :: ds                         


   real, allocatable   :: ps_prime(:,:)              
   real, allocatable   :: t_prime(:,:,:)             
   real, allocatable   :: psi_prime(:,:,:)           
   real, allocatable   :: chi_prime(:,:,:)           
   real, allocatable   :: rh_prime(:,:,:)            
   real, allocatable   :: rhm_prime(:,:,:)           
   real, allocatable   :: aero_prime(:,:,:,:)        

   real, allocatable   :: psi_mean(:,:,:)            
   real, allocatable   :: chi_mean(:,:,:)            
   real, allocatable   :: t_mean(:,:,:)              
   real, allocatable   :: rh_mean(:,:,:)             
   real, allocatable   :: ps_mean(:,:)               
   real, allocatable   :: aero_mean(:,:,:,:)         

   real, allocatable   :: xlat(:,:)                  
   real, allocatable   :: xlon(:,:)                  
   real, allocatable   :: mapfac_m(:,:)              
   real, allocatable   :: mapfac_mx(:,:)             
   real, allocatable   :: mapfac_my(:,:)             
   real, allocatable   :: mapfac_u(:,:)              
   real, allocatable   :: mapfac_v(:,:)              
   real, allocatable   :: znu(:)                     

   integer             :: i, j, k 

   namelist / gen_be_stage1_gsi_nl / start_date, end_date, interval, &
                                 be_method, ne, stage0_gsi_dir, stage1_gsi_dir

   integer             :: num_aeros, kk
   integer, parameter  :: num_aeros_max = 200
   character (len=40)  :: aeros_to_process(1:num_aeros_max)
   logical             :: process_aero

   integer :: ounit,iunit,namelist_unit

   stderr = 0
   stdout = 6


   call da_get_unit(ounit)
   call da_get_unit(iunit)
   call da_get_unit(namelist_unit)

   start_date = '2004030312'
   end_date = '2004033112'
   interval = 24
   be_method = 'NMC'
   ne = 1
   stage0_gsi_dir = '/ptmp/rizvi/data/con200/run_gen_be_gsi/stage0_gsi'                 
   stage1_gsi_dir = '/ptmp/rizvi/data/con200/run_gen_be_gsi/stage1_gsi'                 

   call get_aero_info(process_aero,aeros_to_process,num_aeros)


   write(6,'(a)')' [1] Read Namelist (gen_be_stage1_gsi_nl.nl)'


   open(unit=namelist_unit, file='gen_be_stage1_gsi_nl.nl', &
        form='formatted', status='old', action='read')
   read(namelist_unit, gen_be_stage1_gsi_nl)
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
            filename = trim(stage0_gsi_dir)//'/pert.'//date(1:10)//'.e001'
         else
            write(UNIT=ce,FMT='(i3.3)')member
            filename = trim(stage0_gsi_dir)//'/pert.'//date(1:10)//'.e'//trim(ce)
         endif

         open (iunit, file = trim(filename), form='unformatted')
         read(iunit)date, ni, nj, nk, ds

         if ( count == 1 ) then
            write(6,'(a,3i8)')'    i, j, k dimensions are ', ni, nj, nk
            allocate( ps_prime(1:ni,1:nj) )
            allocate( t_prime(1:ni,1:nj,1:nk) )
            allocate( psi_prime(1:ni,1:nj,1:nk) )
            allocate( chi_prime(1:ni,1:nj,1:nk) )
            allocate( rh_prime(1:ni,1:nj,1:nk) )
            allocate( rhm_prime(1:ni,1:nj,1:nk) )

            allocate( psi_mean(1:ni,1:nj,1:nk) )
            allocate( chi_mean(1:ni,1:nj,1:nk) )
            allocate( t_mean(1:ni,1:nj,1:nk) )
            allocate( rh_mean(1:ni,1:nj,1:nk) )
            allocate( ps_mean(1:ni,1:nj) )

            allocate( xlat(1:ni,1:nj) )     
            allocate( xlon(1:ni,1:nj) )     
            allocate( mapfac_m(1:ni,1:nj) )     
            allocate( mapfac_mx(1:ni,1:nj) )     
            allocate( mapfac_my(1:ni,1:nj) )     
            allocate( mapfac_u(1:ni+1,1:nj) )
            allocate( mapfac_v(1:ni,1:nj+1) )
            allocate( znu(1:nk) )

            psi_mean(:,:,:) = 0.0
            chi_mean(:,:,:) = 0.0
            t_mean(:,:,:) = 0.0
            rh_mean(:,:,:) = 0.0
            ps_mean(:,:) = 0.0

            if ( process_aero ) then
               allocate( aero_prime(1:num_aeros,1:ni,1:nj,1:nk) )
               allocate( aero_mean(1:num_aeros,1:ni,1:nj,1:nk) )
               aero_mean(:,:,:,:) = 0.0
            end if

         end if

         read(iunit)znu 
         read(iunit)xlat
         read(iunit)xlon
         read(iunit)mapfac_mx
         read(iunit)mapfac_my

         read(iunit)psi_prime
         read(iunit)chi_prime
         read(iunit)t_prime
         read(iunit)rh_prime
         read(iunit)rhm_prime
         read(iunit)ps_prime
         if ( process_aero ) read(iunit) aero_prime

         close(iunit)





         psi_mean = ( real( count-1 ) * psi_mean + psi_prime ) * count_inv
         chi_mean = ( real( count-1 ) * chi_mean + chi_prime ) * count_inv
         t_mean = ( real( count-1 ) * t_mean + t_prime ) * count_inv
         rh_mean = ( real( count-1 ) * rh_mean + rh_prime ) * count_inv
         ps_mean = ( real( count-1 ) * ps_mean + ps_prime ) * count_inv
         if ( process_aero ) then
            do kk = 1,num_aeros
               aero_mean(kk,:,:,:) = ( real( count-1 ) * aero_mean(kk,:,:,:) + aero_prime(kk,:,:,:) ) * count_inv
            end do
         end if

      end do  


      call da_advance_cymdh( date, interval, new_date )
      date = new_date
      read(date(1:10), fmt='(i10)')cdate
   end do     

   ncases = count
   write(6,'(a,1x,i4)')' Number of perturbations processed in Stage1 ',ncases


   write(6,'(a)')' [2] Read fields again, and remove time/ensemble/area mean'


   date = start_date
   cdate = sdate
   count = 0

   do while ( cdate <= edate )
      do member = 1, ne
         count = count + 1

         if ( be_method == 'NMC' ) then
            filename = trim(stage0_gsi_dir)//'/pert.'//date(1:10)//'.e001'
         else
            write(UNIT=ce,FMT='(i3.3)')member
            filename = trim(stage0_gsi_dir)//'/pert.'//date(1:10)//'.e'//trim(ce)
         endif

         open (iunit, file = trim(filename), form='unformatted')
         read(iunit)date, ni, nj, nk, ds

         read(iunit)znu 
         read(iunit)xlat
         read(iunit)xlon
         read(iunit)mapfac_mx
         read(iunit)mapfac_my

         read(iunit)psi_prime
         read(iunit)chi_prime
         read(iunit)t_prime
         read(iunit)rh_prime
         read(iunit)rhm_prime
         read(iunit)ps_prime
         if ( process_aero ) read(iunit) aero_prime

         close(iunit)





         write(6,'(a,a)')'    Removing Time mean for date ', date

         psi_prime = psi_prime - psi_mean
         chi_prime = chi_prime - chi_mean
         t_prime = t_prime - t_mean
         rh_prime = rh_prime - rh_mean
         ps_prime = ps_prime - ps_mean
         if ( process_aero ) then
            do kk = 1,num_aeros
               aero_prime(kk,:,:,:) = aero_prime(kk,:,:,:) - aero_mean(kk,:,:,:)
            end do
         end if





         write(ce,'(i3.3)')member

         if( count == 1) then
         filename = trim(stage1_gsi_dir)//'/pert_files' 
         open (unit=99, file = trim(filename), form='formatted')
         end if

         filename = trim(stage1_gsi_dir)//'/pert.gsi.'//date(1:10)//'.e'//ce
         open (ounit, file = trim(filename), form='unformatted')
         write(99,'(a)')trim(filename)

         write(ounit)psi_prime
         write(ounit)chi_prime
         write(ounit)t_prime
         write(ounit)rh_prime
         write(ounit)rhm_prime
         write(ounit)ps_prime
         if ( process_aero ) write(ounit) aero_prime
         close(ounit)

      end do  


      call da_advance_cymdh( date, interval, new_date )
      date = new_date
      read(date(1:10), fmt='(i10)')cdate
   end do     
         close(99)


         filename = trim(stage1_gsi_dir)//'/fixed_field'
         open (ounit, file = filename, form='unformatted')
         write(ounit)date,ni, nj, nk, ncases, ds
         write(ounit)znu   
         write(ounit)xlat
         write(ounit)xlon
         write(ounit)mapfac_mx
         write(ounit)mapfac_my
         close(ounit)

         deallocate( ps_prime)
         deallocate( t_prime)
         deallocate( psi_prime)
         deallocate( chi_prime)
         deallocate( rh_prime)
         deallocate( rhm_prime)
         if ( process_aero ) deallocate ( aero_prime )

         deallocate( psi_mean )
         deallocate( chi_mean )
         deallocate( t_mean )
         deallocate( rh_mean )
         deallocate( ps_mean )
         if ( process_aero ) deallocate ( aero_mean )

         deallocate( xlat)  
         deallocate( xlon)     
         deallocate( mapfac_m )     
         deallocate( mapfac_mx)     
         deallocate( mapfac_my)     
         deallocate( mapfac_u)
         deallocate( mapfac_v)
         deallocate( znu)


end program gen_be_stage1_gsi
