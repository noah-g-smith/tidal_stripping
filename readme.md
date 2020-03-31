Simulate and visualize tidal stripping for two galaxis with this code!

This is designed for linux.
You will require GNU compiler collection (gcc) to compile the fortran code, python3 to run the python code, and ffmpeg to create the video.

Compile the fortran code with 'make'.

Run the program with './main'.
When choosing the mass of the second galaxy consider the mass of the first galaxy is 1 mass unit, so you may want to
choose values between 0.1 and 10.
When choosing the velocity of the second galaxy stick between -0.1 and 0.1, otherwise the second galaxy won't stay in frame for very long,
it will fly off.
The default values will give a stable orbit starting at periastron for the two galaxies.

Run the plotting program with 'python3 plotS.py'.

Create the movie with 'ffmpeg -framerate 25 -i plots/plot_%04d.png -c:v libx264 -profile:v high -crf 20 -pix_fmt yuv420p movie.mp4'.

Before running the program again first remove the data and plot files with 'rm data_* plot_*'.

'movie.mp4' is an example video which uses the default values.
