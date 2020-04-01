import numpy as np
import matplotlib
import math
from matplotlib import pyplot as plt
import glob


data_files = sorted(glob.glob('data/data_*'))
i=0
for file in data_files:
    if(i<1002):
        plt.figure(figsize=(8, 8))
        plt.axis('equal')
        data = np.genfromtxt(fname=file)
        x = data[0, 0]
        y = data[0, 1]
        labels = ['Galaxy one center of mass', 'Galaxy one particles',
        'Galaxy two center of mass', 'Galaxy two particles']
        plt.plot(x, y, color='purple', linestyle="", marker=".", markersize=5,
         label=labels[0])
        x2 = data[1, 0]
        y2 = data[1, 1]
        plt.plot(x2, y2, color='orange', linestyle="", marker=".", markersize=5,
         label=labels[2])
        x3 = data[2:122, 0]
        y3 = data[2:122, 1]
        plt.plot(x3, y3, color='blue', linestyle="", marker=".", markersize=2,
         label=labels[1])
        x4 = data[122:, 0]
        y4 = data[122:, 1]
        plt.plot(x4, y4, color='red', linestyle="", marker=".", markersize=2,
         label=labels[3])
        plt.ylim(-90, 90)
        plt.xlim(-90, 90)
        plt.legend(loc='upper left')
        # plt.legend(bbox_to_anchor=(0,1.02,1,0.2), borderaxespad=0, loc='lower left')
        plt.xlabel('x')
        plt.ylabel('y')
        # plt.subplots_adjust(top=0.9)
        plt.savefig('plots/plot_' + '{:d}'.format(i).zfill(4) + '.png')
        plt.close()
        del data
        i = i + 1
