#!/bin/bash
# Script per mostrar l'ocupació dels directoris passats com a paràmetre
# Autor: Alberto Trujillo
# Exercici 12 15/1/2025
# Versio: 1.0
# Us: ./E12.sh <nom_directori1> <nom_directori2> ... <nom_directoriN>

# Comprova que s'ha passat almenys un paràmetre
if [ $# -lt 1 ]; then
   echo "ERROR: Cal passar almenys un nom de directori com a paràmetre."
   echo "Ús: $0 <nom_directori1> <nom_directori2> ... <nom_directoriN>"
   exit 1
fi

# Funció per calcular l'ocupació del directori
calculate_disk_usage() {
  local dir="$1"
    echo "L'ocupació del directori $dir és:"
    du -sh "$dir"
}

# Iterem sobre la llista dels directoris i calculam l'ocupació
for dir in "$@"; do

    # Comprovam si el directori existeix
    if [ -d "$dir" ]; then
        calculate_disk_usage "$dir"
    else
        echo "ERROR: '$dir' no és un directori."
    fi
done
exit 0

