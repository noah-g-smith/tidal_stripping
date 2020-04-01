FC=gfortran
FFLAGS= -O3 -Wall -Wextra -std=f2008 -fdefault-real-8 -fdefault-double-8 -g -fbacktrace -ffree-line-length-512
SRC= utilities.f90 poten.f90 energy.f90 initial_cond.f90 step.f90 output2.f90 main.f90
OBJ=${SRC:.f90=.o}

%.o: %.f90
	$(FC) $(FFLAGS) -o $@ -c $<

main: ${OBJ}
	$(FC) $(FFLAGS) -o $@ $(OBJ)

clean:
	rm *.o *.mod data/* plots/plot_* movie.mp4
