module step

use poten

implicit none


contains
subroutine step_leapfrog(x,v,a,m,dt,np)


integer, intent(in) :: np
real, dimension(:,:), intent(inout) :: x, v, a
real, dimension(:), intent(in) :: m
real, intent(in) :: dt
integer :: i



do i=1,np
  v(:,i) = v(:,i) + 0.5*dt*a(:,i)
  x(:,i) = x(:,i) + dt*v(:,i)
enddo

call get_accel(x,a,m,np)

do i=1,np
  v(:,i) = v(:,i) + (1./2.)*dt*a(:,i)
end do



end subroutine step_leapfrog
end module step
