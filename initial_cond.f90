module ics

!force us to define all variables
implicit none


contains

  subroutine initialise(x,v,m,np,maxp)

    !subroutine level variables
    integer, intent(in) :: maxp
    integer, intent(out) :: np
    real, intent(out) :: x(3,maxp), v(3,maxp)
    real, intent(out) :: m(maxp)
    real :: a, e, mtot, r, v0, theta, rmin, gal_2_vel, gal_2_mass
    real, parameter :: pi = 3.14159265
    character(256) :: line

      !setup parameters and variables
      x = 0.                 ! All positions zero
      v = 0.                 ! All velocities  zero
      m = 0.                 ! All particle masses zero
      np = 2                 ! Particle number 2
      m(1) = 1.              ! Mass of particle one (galaxy one)
      e = 0.5                ! Eccentricity of orbit
      rmin = 25.
      theta = 60.*(pi/180.)  ! inclination
      a = rmin/(1. - e)
      r = a*(1. + e)         ! Start at apastron

      ! Mass of particle two (galaxy two)
      m(2) = 1./5.
      write(*, *) 'Input galaxy 2 mass. Press enter for default'
      read(*, '(a)') line
      if (len_trim(line)==0) then
        gal_2_mass = 1./5.
      else
        read(line, *) gal_2_mass
      end if
      m(2) = gal_2_mass

      !calculate ics
      mtot = m(1) + m(2)
      x(1,1) = -r*m(2)/mtot   ! galaxy one initial position
      x(1,2) = r*m(1)/mtot    ! galaxy one initial velocity

      ! galaxy two initial velocity
      write(*, *) 'Input galaxy 2 velocity. Press enter for default'
      read(*, '(a)') line
      if (len_trim(line)==0) then
        gal_2_vel = m(1)/mtot*(sqrt(a*(1.-e**2)*mtot)/r)
      else
        read(line, *) gal_2_vel
      end if

      v0 = sqrt(a*(1.-e**2)*mtot)/r
      write(*, *) v0
      v(2,1) = -m(2)/mtot*v0
      v(2,2) = gal_2_vel

      call add_galaxy(x,v,np,maxp,x(:,1),v(:,1),m(1),theta)
      call add_galaxy(x,v,np,maxp,x(:,2),v(:,2),m(2),theta)


  end subroutine initialise


  subroutine add_galaxy(x,v,np,maxp,x0,v0,m0,theta)
    integer, intent(in) :: maxp
    real, intent(in) :: x0(3),v0(3)
    real, intent(in) :: m0
    integer, intent(inout) :: np
    real, intent(out) :: x(3,maxp), v(3,maxp)
    integer :: nrings,nphi,j,i
    real :: dphi,dr,ri,phi,vphi,theta
    real, parameter :: pi = 3.14159265

    nrings = 5
    dr = 3.

    do j=1,nrings
      ri = j*dr
      nphi = 12 + 6*(j-1)
      vphi = sqrt(m0/ri) ! keplerian rotation
      dphi = 2.*pi/nphi
      print*,'r = ',ri,' nphi = ',nphi,' dphi = ',dphi
      do i=1,nphi
        phi = (i-1)*dphi
        np = np + 1
        if (np > maxp) stop
        x(:,np) = x0 + (/ri*cos(phi)*cos(theta),ri*sin(phi),-ri*cos(phi)*sin(theta)/)
        v(:,np) = v0 + (/-vphi*sin(phi)*cos(theta), vphi*cos(phi), vphi*sin(phi)*sin(theta)/)
      enddo
    enddo
    print*,' setup ',np,' particles'
  end subroutine add_galaxy


!end module
end module ics
