import numpy as np
import csv
import matplotlib.pyplot as plt
from tkinter import *

class mesure_acceleration:
	"""docstring for ClassName"""
	def __init__(self, mesure_discrete, freq_acquisition):
	    self.__akTs = mesure_discrete
	    self.__f = freq_acquisition 
	
	def periode_echantillonnage(self):
		""" elle retourne periode d'echantillonnage"""
		Ts = 1/self.__f
		return Ts 	

	def affiche(self,donnee_echantillonnees,Ts):
		"""Elle affiche le jeu de donnees déjà coverti"""
		N = len(donnee_echantillonnees)
		kTs = np.linspace(0,N*Ts-Ts,N)
		plt.plot(kTs,donnee_echantillonnees)
		plt.show()

	def convert_csv(self):
		"""" elle converti le jeu de donnees en une liste de valeurs"""
		l = []
		d = []
		with open( self.__akTs, newline='') as akts:
			acc_discrete = csv.reader(akts,delimiter=' ', quotechar='|')
			
			for row in acc_discrete:
				if row != []:
					l.append(row)
			l.pop(0)
			
			for i in range(len(l)):
				d.append(float(l[i][0]))
		return d 

	def trapeze(self,acc_discrete,Ts):
		
		N = len(acc_discrete) # nombre de point du signale échantillonné
		
		# première intégration 
		vitesse_discrete = [0]*(N-1)
		for i in range (N-2):
			vitesse_discrete[i+1] = vitesse_discrete[i] + (acc_discrete[i+1] + acc_discrete[i])*(Ts/2)

        # Ajout de la condition initiale ou l'offset
		vitesse_discrete_centree = [0]*(N)
		for i in range(N-1):
			vitesse_discrete_centree[i] = vitesse_discrete[i]-((max(vitesse_discrete) - min(vitesse_discrete))/2)
		
		# Deuxième intégration 
		deplacement_discret = [0]*(N-1)
		for i in range(N-2):
			deplacement_discret[i+1] = deplacement_discret[i] + (vitesse_discrete_centree[i+1] + vitesse_discrete_centree[i])*(Ts/2)

		return [vitesse_discrete_centree, deplacement_discret]
	
	def runge_kutta_4(self,acc_discrete,delta_t):

		# delt_a c'est le pas de temps a définir
		N = len(acc_discrete)     # Nombre d'échantillons
		vitesse_discrete = [0]*N
		vitesse_discrete_centree = [0]*N
		deplacement_discret = [0]*N

		# Première intégration
		for i in range(N-2):
			vitesse_discrete[i+1] = vitesse_discrete[i] + ((1/6)*acc_discrete[i] + (4/6)*(acc_discrete[i+1]-acc_discrete[i])/2 +(1/6)*acc_discrete[i+1])*delta_t
		
		# Annulation de l'offset
		for i in range(N-1):
			vitesse_discrete_centree[i] = vitesse_discrete[i] -(max(vitesse_discrete)-min(vitesse_discrete))/2
		
		# Deuxième intégration
		for i in range(N-2):
			deplacement_discret[i+1] = deplacement_discret[i] + vitesse_discrete_centree[i]*delta_t + (1/2)*((1/3)*acc_discrete[i]+(2/3)*(acc_discrete[i+1]-acc_discrete[i])/2)*delta_t*delta_t

		return [vitesse_discrete_centree, deplacement_discret]