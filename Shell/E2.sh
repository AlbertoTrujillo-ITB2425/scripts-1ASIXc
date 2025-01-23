#!/bin/bash
#Exercici 2 15/1/2025
#Autor: Alberto Trujillo
#Versió: 1.0

# Aquest script mostra una salutació personalitzada amb l'hora, la data i el nom d'usuari.

# Definim una variable per emmagatzemar el nom d'usuari.
# La variable $USER conté el nom d'usuari actual del sistema.
nomusuari="$USER"

# Obtenim l'hora actual en format de 24 hores (HH:MM).
hora=$(date +%H:%M)

# Obtenim la data actual en format dia/mes/any.
DiaMesAny=$(date +%d/%m/%Y)

# Mostrem un missatge a la terminal, personalitzant la salutació amb les variables.
echo "Hola món, són les $hora del dia $DiaMesAny i soc l’usuari $nomusuari"