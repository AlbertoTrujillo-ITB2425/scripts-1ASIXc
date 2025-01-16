#!/bin/bash
# Script per llegir un fitxer CSV i eliminar usuaris del sistema
# Autor: Alberto Trujillo
# 16/1/2025
# Versio: 1.0
# Us: ./delete.sh <fitxer_csv>

# Comprovacio de paràmetres
if [ "$#" -ne 1 ]; then
   echo "Error: S'ha de passar el nom del fitxer CSV com a argument"
   exit 1
fi

# Fitxer CSV
CSV_FILE="$1"

# Comprovacio que el fitxer existeix
if [ ! -f "$CSV_FILE" ]; then
   echo "Error: El fitxer $CSV_FILE no existeix"
   exit 1
fi

# Log file
LOG_FILE="logs.txt"

# Creació del fitxer logs si no existeix
if [ ! -f "$LOG_FILE" ]; then
   touch "$LOG_FILE"
fi

# Lectura del fitxer CSV i eliminació dels usuaris
while IFS=, read -r user shell home password email; do
   # Comprovem si l'usuari existeix
   if id "$user" &>/dev/null; then
       # Eliminació de l'usuari
       sudo userdel -r "$user"
       echo "Usuari $user eliminat del sistema"
       echo "Usuari $user eliminat del sistema" >> "$LOG_FILE"
   else
       echo "L'usuari $user no existeix al sistema"
       echo "L'usuari $user no existeix al sistema" >> "$LOG_FILE"
   fi
done < "$CSV_FILE"
