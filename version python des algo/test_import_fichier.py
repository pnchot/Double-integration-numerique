import numpy as np
import csv
import matplotlib.pyplot as plt
from tkinter import *
l=[]
with open( 'acc.csv', newline='') as akts:
        acc_discrete = csv.reader(akts,delimiter=' ', quotechar='|')
        for row in acc_discrete:
                if row != []:
                        l.append(row)
        l.pop(0)
        d = []
        for i in range(len(l)):
                d.append(float(l[i][0]))

plt.plot(range(len(d[150000:230000])),d[150000:230000])
plt.show()

#N = 100
#Ts = 1/4
#print(Ts)
#print( np.linspace(0,N*Ts-Ts,N))
