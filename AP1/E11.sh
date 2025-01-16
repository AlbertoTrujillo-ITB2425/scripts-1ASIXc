#!/bin/bash
#Exercici 11 15/1/2025
#Autor: Alberto Trujillo
#Versió: 1.0
#US: ./E11.sh

#Obtenim la llista dels directoris de /home
home_dirs=$(ls /home)

#Funció per calcular l'ocupació del directori
calculate_disk_usage() {
  local dir="$1"
    echo "L'ocupació del directori $dir és:"
    du -sh "$dir"
}

#Iterem sobre la llista dels directoris i calculam l'ocupació
for dir in $home_dirs; do

    #Comprovam si el directori existeix
    if [ -d "/home/$dir" ]; then
        calculate_disk_usage "/home/$dir"
    else
        echo "ERROR: '/home/$dir' no és un directori."
    fi
    done
exit 0
