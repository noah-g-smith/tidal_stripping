module poten
implicit none

contains
  subroutine get_accel(x,a,m,np)

    !variables
    integer, intent(in) :: np
    real, dimension(:,:), intent(in) :: x
    real, dimension(:,:), intent(out) :: a
    real, dimension(:), intent(in) :: m
    real, dimension(:), allocatable :: dx
    real :: r2, r
    integer :: i, j

    !allocate arrays
    allocate(dx(3))

    a = 0. ! set all accelerations to zero

    do i=1,np
      do j=1,2
        if(j /= i) then
          dx = x(:,i) - x(:,j)
          r2 = dot_product(dx,dx)
          r = sqrt(r2)
          a(:,i) = a(:,i) - m(j)*(dx/(r**3))
        endif
      enddo
    enddo

  end subroutine get_accel




!function to return the total potential energy per unit mass
real function potential(x,m)

!variables
real, dimension(:,:), intent(in) :: x
real, dimension(:), intent(in) :: m
real, dimension(:), allocatable :: dx
real :: r, phi
integer :: i, j

!allocate arrays
allocate(dx(3))

potential = 0.
do i=1,2
  phi = 0.    !potential for particle i
  do j=i+1,2
    dx = x(:,i) - x(:,j)
    r = sqrt(dot_product(dx,dx))
    phi = phi - m(j)/r
  enddo
  potential = potential + m(i)*phi
enddo

end function potential



!end module
end module poten
