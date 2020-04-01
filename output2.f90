module output2

implicit none

contains
  subroutine datawrite(x,v,m,np,time,mn,filename, fileplace, filenumber)

    !variables
    real(8), dimension(:,:), intent(in) :: x,v
    real(8), dimension(:), intent(in) :: m
    real, intent(in) :: time
    integer, intent(in) :: mn, np
    integer, intent(inout) :: filenumber
    integer :: i
    character(len=20), intent(inout) :: filename
    character(len=5), intent(in) :: fileplace

    !select case allows for more flexibility in file handeling
    select case(mn)

    !case 1 allows a pre-existing file to be overwritten
    case(1)


      !create and write to file
      write(filename,'(a,i4.4)')'data_',filenumber
      open(1,file=fileplace//filename,status='replace',position='append')
      do i=1,np
        write(1,*) x(:,i), v(:,i), m(i), time
      end do
      close(1)

    !case 2 allows a pre-existing file to be appended
    case(2)

      !write to end of file
      open(1,file=fileplace//filename,status='old',position='append')
      do i=1,np
        write(1,*) x(:,i), v(:,i), m(i), time
      end do
      close(1)


    !case 3 allows a new file to be created when an old file exists
    case(3)
      

5     filenumber = filenumber + 1
      write(filename,'(a,i4.4)')'data_',filenumber
      open(1,file=fileplace//filename,status='new',err=5)
      do i=1,np
        write(1,*) x(:,i), v(:,i), m(i), time
      end do
      close(1)


    !case 4 checks to see if file exists, if it does then overwrite, if not then create new file
    case(4)

      filenumber = filenumber + 1
      write(filename,'(a,i4.4)')'data_',filenumber
      open(1,file=fileplace//filename, status='replace', position='append')
      do i=1,np
        write(1,*) x(:,i), v(:,i), m(i), time
      end do
      close(1)

    end select

  end subroutine datawrite
end module
