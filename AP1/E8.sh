#!/bin/bash
# Script per mostrar el contingut d'un directori
# Autor: Alberto Trujillo
# Exercici 8 15/1/2025
# Versio: 1.0
# Us: ./E8.sh <nom_directori>

# Comprova que s'ha passat exactament un paràmetre
if [ $# -ne 1 ]; then
   echo "ERROR: Cal passar un nom de directori com a paràmetre."
   echo "Ús: $0 <nom_directori>"
   exit 1
fi

# Comprova si l'argument passat és un directori
if [ -d "$1" ]; then
   echo "El contingut del directori $1 és:"
   ls -l "$1"
# si fa un ls -l del contingut es un directori si no no es un directori 
else
   echo "ERROR: '$1' no és un directori."
fi
