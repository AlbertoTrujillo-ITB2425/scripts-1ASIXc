#!/bin/bash
#Exercici 2 15/1/2025
#Autor: Alberto Trujillo
#Versió: 1.0

# Definim la variable nomusuari
nomusuari="$USER"  # O pots assignar-li un valor com "el_teu_nom"

# Obtenim l'hora i la data actual
hora=$(date +%H:%M)
DiaMesAny=$(date +%d/%m/%Y)

# Mostrem el missatge
echo "Hola món, son les $hora del dia $DiaMesAny i soc l’usuari $nomusuari"

