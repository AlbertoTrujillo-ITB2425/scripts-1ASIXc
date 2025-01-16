#!/bin/bash
#Exercici 2 15/1/2025
#Autor: Alberto Trujillo
#Versió: 1.0
#US: ./E4.sh <1parametre> <2parametre> <3parametre>


# Comprovem que s'han passat 3 parametres
if [ "$#" -ne 3 ]; then
    echo "Error: Es requereixen 3 parametres."
    echo "Us: $0 <primer_parametre> <segon_parametre> <tercer_parametre>"
    exit 1
fi

# Assignem els parametres a variables
primer_parametre=$1
segon_parametre=$2
tercer_parametre=$3

# Mostrem els resultats
echo "Nom de l'script: $0"
echo "Valor del primer parametre de l'script: $primer_parametre"
echo "Valor del segon parametre de l'script: $segon_parametre"
echo "Valor del tercer parametre de l'script: $tercer_parametre"

