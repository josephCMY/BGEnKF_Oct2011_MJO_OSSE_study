












!
! Public domain.
!

!>
!! Module to retrieve a variable from a WRF I/O Internal format file.
!!
!! This module uses an index generated by module_io_int_idx.
!! Note that this module contains ifdef's so if it is compiled
!! with 1 it will use MPI IO routines. However if it
!! is not, then the Fortran 2003 stream facility is used to
!! read at a position in the file.
!!
!! Note that WRF should be compiled with file conversion for
!! big endian. This is the current default.
!!
!! 1
!! -----------
!! If the MPI implementations actually supported the external32
!! view on a file we could simply call:
!!
!! MPI_File_set_view(..., "external32", ...)
!!
!! However most do not. Instead we have do a native view and then
!! do a byte order rearrangement.
!!
!! Usage consists of:
!! 1) Creating an index of records in the file
!! 2) Opening the file with MPI
!! 3) Retrieving the data
!! 4) Closing the file with MPI
!!
!! Example:
!!
!! USE module_io_int_idx, only: io_int_index, r_info
!! USE module_io_int_read, only: io_int_fetch_data
!!
!! type(r_info), pointer :: r(:) => NULL()  ! Define the array of records
!!
!! call io_int_index(filename, r, ierr)     ! Get an index of reocrds
!!
!! call mpi_file_open(mpi_comm_world, trim(filename), &
!!                    mpi_mode_rdonly, mpi_info_null, &
!!                    iunit, ierr)          ! MPI Open the file
!!
!! call io_int_fetch_data(iunit, r, 'TRUELAT1', garb, ierr)
!!                                          ! Get an record (into garb)
!!
!! call mpi_file_close(iunit, ierr)         ! Close the file
!!
!! SERIAL
!! ------
!!
!! Usage consists of:
!! 1) Creating an index of records in the file
!! 2) Opening the file
!! 3) Retrieving the data
!! 4) Closing the file
!!
!! Example:
!!
!! USE module_io_int_idx, only: io_int_index, r_info
!! USE module_io_int_read, only: io_int_fetch_data
!!
!! type(r_info), pointer :: r(:) => NULL() ! Define the array of records
!!
!! call io_int_index(filename, r, ierr)    ! Get an index of reocrds
!!
!! open(unit=iunit, file=trim(filename), &
!!      access='stream', status='old',   &
!!      convert='big_endian', iostat=ierr)
!!
!! call io_int_fetch_data(iunit, r, 'TRUELAT1', garb, ierr)
!!                                         ! Get an record (into garb)
!!
!! call close(iunit, iostat=ierr)          ! Close the file

module module_io_int_read

    use module_io_int_idx,           only: io_int_loc, r_info
    use, intrinsic :: iso_c_binding, only: c_int32_t

    implicit none

    private
    public :: io_int_fetch_data

    integer, parameter :: llong_t  = selected_int_kind(16)  ! int64_t
    character(len=128) :: message

    interface
        integer(c_int32_t)      &
        pure function ntohl(netlong) &
            bind(c, name="ntohl")
            import :: c_int32_t
            integer(c_int32_t), value, intent(in) :: netlong
        end function
    end interface
    interface io_int_fetch_data
        module procedure  read_i0, read_i1, read_i2, read_i3, &
                          read_r0, read_r1, read_r2, read_r3, &
                          read_c1
    end interface io_int_fetch_data

    include "mpif.h"

contains

    !>
    !! Read a single integer
    !
    subroutine read_i0(ifd, records, varname, dst, ierr)

    integer,                 intent(in)  :: ifd
    type(r_info), pointer,   intent(in)  :: records(:)
    character(len=*),        intent(in)  :: varname
    integer,                 intent(out) :: dst
    integer,                 intent(out) :: ierr

    integer(kind=mpi_offset_kind)       :: offset
    integer                             :: count
    integer                             :: tmp

    call io_int_loc(varname, records, offset, count, ierr)
    if (ierr .ne. 0) then
        return
    end if

    call mpi_file_read_at(ifd, offset, tmp, 1, &
                          mpi_integer4, mpi_status_ignore, ierr)
    if (ierr .ne. 0) then
        write(message,*) 'MPI IO: Unable to read ', varname
        call wrf_error_fatal3("module_io_int_read.F90", 143, message)
        return
    end if
    dst = ntohl(tmp)

!    write(message,*) 'read_i0: ', varname, ':', dst
!    call wrf_debug(2, message)

    end subroutine read_i0

    !>
    !! Read a 1D integer array.
    !
    subroutine read_i1(ifd, records, varname, dst, ierr)

    integer,                 intent(in)    :: ifd
    type(r_info), pointer,   intent(in)    :: records(:)
    character(len=*),        intent(in)    :: varname
    integer,                 intent(inout) :: dst(:)
    integer,                 intent(out)   :: ierr

    integer(kind=mpi_offset_kind)          :: offset
    integer                                :: count
    integer                                :: num
    integer                                :: i
    integer                                :: its, ite
    integer, allocatable, dimension(:)     :: tmp

    call io_int_loc(varname, records, offset, count, ierr)
    if (ierr .ne. 0) then
        return
    end if

    its = lbound(dst,1)
    ite = ubound(dst,1)
    num = ite - its + 1

    allocate(tmp(its:ite), stat=ierr)
    if (ierr .ne. 0) then
        call wrf_error_fatal3("module_io_int_read.F90", 182, &
             'Unable to allocate a temporary array')
        return
    end if
    tmp = 0

    if (num .ne. count) then
        write(message,*) 'MPI IO: Reading less data, than in file', num, &
                         '(instead of ', count, ')'
        call wrf_debug(1, message)
    end if
    call mpi_file_read_at(ifd, offset, tmp, num, &
                          mpi_integer4, mpi_status_ignore, ierr)
    if (ierr .ne. 0) then
        write(message,*) 'MPI IO: Unable to read ', varname
        call wrf_error_fatal3("module_io_int_read.F90", 197, message)
        return
    end if

    forall(i=its:ite)
        dst(i) = transfer(ntohl(tmp(i)), 1.0)
    end forall

    deallocate(tmp)
!     write(message,*) 'read_i1: ', varname, ':', dst(1,1)
!     call wrf_debug(2, message)

    end subroutine read_i1

    !>
    !! Read a 2D integer array.
    !
    subroutine read_i2(ifd, records, varname, dst, ierr)

    integer,                 intent(in)    :: ifd
    type(r_info), pointer,   intent(in)    :: records(:)
    character(len=*),        intent(in)    :: varname
    integer,                 intent(inout) :: dst(:,:)
    integer,                 intent(out)   :: ierr

    integer(kind=mpi_offset_kind)          :: offset
    integer                                :: count
    integer                                :: num
    integer                                :: i, j
    integer                                :: its, ite, jts, jte
    integer, allocatable, dimension(:,:)   :: tmp

    call io_int_loc(varname, records, offset, count, ierr)
    if (ierr .ne. 0) then
        return
    end if

    its = lbound(dst,1)
    ite = ubound(dst,1)
    jts = lbound(dst,2)
    jte = ubound(dst,2)
    num = (ite - its + 1) * (jte - jts +1)

    allocate(tmp(its:ite, jts:jte), stat=ierr)
    if (ierr .ne. 0) then
        call wrf_error_fatal3("module_io_int_read.F90", 242, &
             'Unable to allocate a temporary array')
        return
    end if
    tmp = 0

    if (num .ne. count) then
        write(message,*) 'MPI IO: Reading less data, than in file', num, &
                         '(instead of ', count, ')'
        call wrf_debug(1, message)
    end if
    call mpi_file_read_at(ifd, offset, tmp, num, &
                          mpi_integer4, mpi_status_ignore, ierr)
    if (ierr .ne. 0) then
        write(message,*) 'MPI IO: Unable to read ', varname
        call wrf_error_fatal3("module_io_int_read.F90", 257, message)
        return
    end if

    forall(i=its:ite, j=jts:jte)
        dst(i,j) = transfer(ntohl(tmp(i,j)), 1.0)
    end forall

    deallocate(tmp)
!     write(message,*) 'read_i2: ', varname, ':', dst(1,1)
!     call wrf_debug(2, message)

    end subroutine read_i2

    !>
    !! Read a 3D integer array
    !
    subroutine read_i3(ifd, records, varname, dst, ierr)

    integer,                 intent(in)    :: ifd
    type(r_info), pointer,   intent(in)    :: records(:)
    character(len=*),        intent(in)    :: varname
    integer,                 intent(inout) :: dst(:,:,:)
    integer,                 intent(out)   :: ierr

    integer(kind=mpi_offset_kind)          :: offset
    integer                                :: count
    integer                                :: num
    integer                                :: i, j, k
    integer                                :: its, ite, jts, jte, kts, kte
    integer, allocatable, dimension(:,:,:) :: tmp

    call io_int_loc(varname, records, offset, count, ierr)
    if (ierr .ne. 0) then
        return
    end if

    its = lbound(dst,1)
    ite = ubound(dst,1)
    jts = lbound(dst,2)
    jte = ubound(dst,2)
    kts = lbound(dst,3)
    kte = ubound(dst,3)
    num = (ite - its + 1) * (jte - jts + 1) * (kte - kts + 1)

    allocate(tmp(its:ite, jts:jte, kts:kte), stat=ierr)
    if (ierr .ne. 0) then
        call wrf_error_fatal3("module_io_int_read.F90", 304, &
             'Unable to allocate a temporary array')
        return
    end if
    tmp = 0

    if (num .ne. count) then
        write(message,*) 'MPI IO: Reading less data, than in file', num, &
                         '(instead of ', count, ')'
        call wrf_debug(1, message)
    end if
    call mpi_file_read_at(ifd, offset, tmp, num, &
                          mpi_integer4, mpi_status_ignore, ierr)

    if (ierr .ne. 0) then
        write(message,*) 'MPI IO: Unable to read ', varname
        call wrf_error_fatal3("module_io_int_read.F90", 320, message)
        return
    end if

    forall(i=its:ite, j=jts:jte, k=kts:kte)
        dst(i,j,k) = transfer(ntohl(tmp(i,j,k)), 1.0)
    end forall

    deallocate(tmp)

!     write(message,*) 'read_i3: ', varname, ':', dst(1,1,1)
!     call wrf_debug(2, message)

    end subroutine read_i3

    !>
    !! Read a single real.
    !
    subroutine read_r0(ifd, records, varname, dst, ierr)

    integer,                 intent(in)  :: ifd
    type(r_info), pointer,   intent(in)  :: records(:)
    character(len=*),        intent(in)  :: varname
    real,                    intent(out) :: dst
    integer,                 intent(out) :: ierr

    integer(kind=mpi_offset_kind)        :: offset
    integer                              :: count
    integer                              :: tmp

    call io_int_loc(varname, records, offset, count, ierr)
    if (ierr .ne. 0) then
        return
    end if

    call mpi_file_read_at(ifd, offset, tmp, 1, &
                          mpi_integer4,  mpi_status_ignore, ierr)
    if (ierr .ne. 0) then
        write(message,*) 'MPI IO: Unable to read ', varname
        call wrf_error_fatal3("module_io_int_read.F90", 359, message)
        return
    end if
    dst = transfer(ntohl(tmp), 1.0)

!    write(message,*) 'read_r0: ', varname, ':', dst
!    call wrf_debug(2, message)

    end subroutine read_r0

    !>
    !! Read a 1D real array.
    !
    subroutine read_r1(ifd, records, varname, dst, ierr)

    integer,                 intent(in)    :: ifd
    type(r_info), pointer,   intent(in)    :: records(:)
    character(len=*),        intent(in)    :: varname
    real,                    intent(inout) :: dst(:)
    integer,                 intent(out)   :: ierr

    integer(kind=mpi_offset_kind)          :: offset
    integer                                :: count
    integer                                :: num
    integer                                :: i
    integer                                :: its, ite
    integer, allocatable, dimension(:)     :: tmp

    call io_int_loc(varname, records, offset, count, ierr)
    if (ierr .ne. 0) then
        return
    end if

    its = lbound(dst,1)
    ite = ubound(dst,1)
    num = ite - its + 1

    allocate(tmp(its:ite), stat=ierr)
    if (ierr .ne. 0) then
        call wrf_error_fatal3("module_io_int_read.F90", 398, &
             'Unable to allocate a temporary array')
        return
    end if
    tmp = 0

    if (num .ne. count) then
        write(message,*) 'MPI IO: Reading less data, than in file', num, &
                         '(instead of ', count, ')'
        call wrf_debug(1, message)
    end if
    call mpi_file_read_at(ifd, offset, tmp, num, &
                          mpi_integer4, mpi_status_ignore, ierr)
    if (ierr .ne. 0) then
        write(message,*) 'MPI IO: Unable to read ', varname
        call wrf_error_fatal3("module_io_int_read.F90", 413, message)
        return
    end if

    forall(i=its:ite)
        dst(i) = transfer(ntohl(tmp(i)), 1.0)
    end forall

    deallocate(tmp)
!     write(message,*) 'read_r1: ', varname, ':', dst(1,1)
!     call wrf_debug(2, message)

    end subroutine read_r1

    !>
    !! Read a 2D real array.
    !
    subroutine read_r2(ifd, records, varname, dst, ierr)

    integer,                 intent(in)    :: ifd
    type(r_info), pointer,   intent(in)    :: records(:)
    character(len=*),        intent(in)    :: varname
    real,                    intent(inout) :: dst(:,:)
    integer,                 intent(out)   :: ierr

    integer(kind=mpi_offset_kind)          :: offset
    integer                                :: count
    integer                                :: num
    integer                                :: i, j
    integer                                :: its, ite, jts, jte
    integer, allocatable, dimension(:,:)   :: tmp

    call io_int_loc(varname, records, offset, count, ierr)
    if (ierr .ne. 0) then
        return
    end if

    its = lbound(dst,1)
    ite = ubound(dst,1)
    jts = lbound(dst,2)
    jte = ubound(dst,2)
    num = (ite - its + 1) * (jte - jts + 1)

    allocate(tmp(its:ite, jts:jte), stat=ierr)
    if (ierr .ne. 0) then
        call wrf_error_fatal3("module_io_int_read.F90", 458, &
             'Unable to allocate a temporary array')
        return
    end if
    tmp = 0

    if (num .ne. count) then
        write(message,*) 'MPI IO: Reading less data, than in file', num, &
                         '(instead of ', count, ')'
        call wrf_debug(1, message)
    end if
    call mpi_file_read_at(ifd, offset, tmp, num, &
                          mpi_integer4, mpi_status_ignore, ierr)
    if (ierr .ne. 0) then
        write(message,*) 'MPI IO: Unable to read ', varname
        call wrf_error_fatal3("module_io_int_read.F90", 473, message)
        return
    end if

    forall(i=its:ite, j=jts:jte)
        dst(i,j) = transfer(ntohl(tmp(i,j)), 1.0)
    end forall

    deallocate(tmp)
!     write(message,*) 'read_r2: ', varname, ':', dst(1,1)
!     call wrf_debug(2, message)

    end subroutine read_r2

    !>
    !! Read a 3D real array
    !
    subroutine read_r3(ifd, records, varname, dst, ierr)

    integer,                 intent(in)    :: ifd
    type(r_info), pointer,   intent(in)    :: records(:)
    character(len=*),        intent(in)    :: varname
    real,                    intent(inout) :: dst(:,:,:)
    integer,                 intent(out)   :: ierr

    integer(kind=mpi_offset_kind)          :: offset
    integer                                :: count
    integer                                :: num
    integer                                :: i, j, k
    integer                                :: its, ite, jts, jte, kts, kte
    integer, allocatable, dimension(:,:,:) :: tmp

    call io_int_loc(varname, records, offset, count, ierr)
    if (ierr .ne. 0) then
        return
    end if

    its = lbound(dst,1)
    ite = ubound(dst,1)
    jts = lbound(dst,2)
    jte = ubound(dst,2)
    kts = lbound(dst,3)
    kte = ubound(dst,3)
    num = (ite - its + 1) * (jte - jts + 1) * (kte - kts + 1)

    allocate(tmp(its:ite, jts:jte, kts:kte), stat=ierr)
    if (ierr .ne. 0) then
        call wrf_error_fatal3("module_io_int_read.F90", 520, &
             'Unable to allocate a temporary array')
        return
    end if
    tmp = 0

    if (num .ne. count) then
        write(message,*) 'MPI IO: Reading less data, than in file', num, &
                         '(instead of ', count, ')'
        call wrf_debug(1, message)
    end if
    call mpi_file_read_at(ifd, offset, tmp, num, &
                          mpi_integer4, mpi_status_ignore, ierr)

    if (ierr .ne. 0) then
        write(message,*) 'MPI IO: Unable to read ', varname
        call wrf_error_fatal3("module_io_int_read.F90", 536, message)
        return
    end if

    forall(i=its:ite, j=jts:jte, k=kts:kte)
        dst(i,j,k) = transfer(ntohl(tmp(i,j,k)), 1.0)
    end forall

    deallocate(tmp)

!     write(message,*) 'read_r3: ', varname, ':', dst(1,1,1)
!     call wrf_debug(2, message)

    end subroutine read_r3

    !>
    !! Read a 1D character array.
    !
    subroutine read_c1(ifd, records, varname, dst, ierr)

    integer,                 intent(in)    :: ifd
    type(r_info), pointer,   intent(in)    :: records(:)
    character(len=*),        intent(in)    :: varname
    character(len=*),        intent(inout) :: dst
    integer,                 intent(out)   :: ierr

    integer(kind=mpi_offset_kind)          :: offset
    integer                                :: count
    integer                                :: num
    integer                                :: i
    integer, allocatable, dimension(:)     :: tmp

    call io_int_loc(varname, records, offset, count, ierr)
    if (ierr .ne. 0) then
        return
    end if

    num = len(dst)

    allocate(tmp(num), stat=ierr)
    if (ierr .ne. 0) then
        call wrf_error_fatal3("module_io_int_read.F90", 577, &
             'Unable to allocate a temporary array')
        return
    end if
    tmp = 0

    call mpi_file_read_at(ifd, offset, tmp, num, &
                          mpi_integer4, mpi_status_ignore, ierr)
    if (ierr .ne. 0) then
        write(message,*) 'MPI IO: Unable to read ', varname
        call wrf_error_fatal3("module_io_int_read.F90", 587, message)
        return
    end if

! PGI and GNU fortran compilers do not like forall loops over
! character arrays.
! PGI: TPR#19016
! GNU: http://gcc.gnu.org/bugzilla/show_bug.cgi?id=50069
!
! XLF does not like transfer() with the mold being an array,
! so we use achar() instead.
!
!    forall(i=1:num)
!        dst(i:i) = transfer(ntohl(tmp(i)), dst)
!    end forall

    do i=1,count
        dst(i:i) = achar(ntohl(tmp(i)))
    end do

    deallocate(tmp)
!     write(message,*) 'read_c1: ', varname, ':', dst(1,1)
!     call wrf_debug(2, message)

    end subroutine read_c1

end module module_io_int_read
