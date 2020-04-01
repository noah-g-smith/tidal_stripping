module energy
  implicit none

contains
  subroutine get_conserved(x,v,m,en,mom,angmom,np)
    !Returns conserved variables (momentum, angular momentum, and energy) from
    !variables postion, velocity, and previous conserved variables values

    use utils, only:cross_product
    use poten, only:potential
    integer, intent(in) :: np
    real(8), intent(in) :: x(3,np), v(3,np)
    real(8), intent(in) :: m(np)
    real(8), intent(inout) :: en
    real(8), intent(inout) :: mom(3), angmom(3)
    real(8) :: ekin
    real(8) :: angi(3)
    integer :: i

    mom = 0.
    ekin = 0.
    angmom = 0.

    do i=1,np
      ekin = ekin + 0.5*m(i)*dot_product(v(:,i),v(:,i))
      mom = mom + m(i)*v(:,i)
      call cross_product(x(:,i),v(:,i),angi)
      angmom = angmom + m(i)*angi
    enddo
    en = ekin + potential(x, m)

  end subroutine get_conserved

end module energy
