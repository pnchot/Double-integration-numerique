from Analyse_Vibratoire import *

# définition de l'acquisition
acceleration = mesure_acceleration('acc.csv',19200)
Ts = acceleration.periode_echantillonnage()
akTs = acceleration.convert_csv()

# Intégrations numériques
#resultats_1 = acceleration.trapeze(akTs[150000:240000],Ts) # Méthode des trapèzes
#vitesse_1 = resultats_1[0][:]
#deplacement_1 = resultats_1[1][:]

resultats_2 = acceleration.runge_kutta_4(akTs[150000:240000],Ts) # Méthode des Runge Kutta 4
vitesse_2 = resultats_2[0][:]
deplacement_2 = resultats_2[1][:]

# Affichage des courbes
acceleration.affiche(akTs[150000:240000],Ts)
acceleration.affiche(vitesse_2,Ts)
acceleration.affiche(deplacement_2,Ts)