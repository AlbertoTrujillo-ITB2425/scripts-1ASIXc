#!/bin/bash
#Exercici 2 15/1/2025
#Autor: Alberto Trujillo
#Versió: 1.0
#US: ./E4.sh <1parametre> <2parametre> <3parametre>

# Comprovem que s'han passat 3 paràmetres
if [ "$#" -ne 3 ]; then
    # Si el nombre de paràmetres és diferent de 3, mostrem un missatge d'error
    echo "Error: Es requereixen exactament 3 paràmetres."
    echo "Us: $0 <primer_paràmetre> <segon_paràmetre> <tercer_paràmetre>"
    # Sortim del script amb un codi d'error
    exit 1
fi

# Assignem els paràmetres a variables per facilitar la manipulació
primer_parametre=$1
segon_parametre=$2
tercer_parametre=$3

# Mostrem els valors dels paràmetres per verificar que s'han assignat correctament
echo "Nom de l'script: $0"
echo "El primer paràmetre és: $primer_parametre"
echo "El segon paràmetre és: $segon_parametre"
echo "El tercer paràmetre és: $tercer_parametre"


