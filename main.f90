program nbody

!dependencies
use ics, only:initialise
use poten
use step, only: step_leapfrog
use output2, only: datawrite
use utils, only: cross_product
use energy, only: get_conserved

implicit none

!variables
real(8), dimension(:,:), allocatable :: x, v, a
real(8), dimension(:), allocatable :: m
real(8) :: dt, tmax, time, dtout
integer :: nsteps, i, mn, nout, np, filenumber, filenumber2
integer, parameter :: maxp=1000
character(len=20) :: filename, filename2
character(len=5) :: fileplace
real(8) :: en
real(8) :: mom(3), angmom(3)


dt = 0.01

!allocate variables
allocate(x(3,maxp),v(3,maxp),a(3,maxp))
allocate(m(maxp))

!ics
call initialise(x,v,m,np,maxp)
call get_accel(x,a,m,np)


!write initial conditions
mn=4
filenumber = -1
fileplace = 'data/'
filename = 'data_'
call datawrite(x,v,m,np,time,mn,filename,fileplace,filenumber)

!setup for do loop
tmax = 5000
nsteps = int(tmax/dt) + 1
dtout = 10
nout = nint(dtout/dt)

!do loop for time
filenumber2 = -1
4 filenumber2 = filenumber2 + 1
write(filename2,'(a,i4.4)') 'data_conserv_',filenumber2
open(unit=63,file=fileplace//filename2,status='new',err=4)
do i=1, nsteps
  call step_leapfrog(x,v,a,m,dt,np)
  time = i*dt
  if(mod(i,nout).eq.0) then
    call datawrite(x,v,m,np,time,mn,filename,fileplace,filenumber)
  end if
  call get_conserved(x,v,m,en,mom,angmom,np)
  write(63,*) time, en, mom, angmom
enddo
close(unit=63)



end program nbody
