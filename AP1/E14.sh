#!/bin/bash
# Script per llegir un fitxer CSV i crear usuaris al sistema
# Autor: Alberto Trujillo
# Exercici 14 15/1/2025
# Versio: 1.0
# Us: ./E14.sh <fitxer_csv>

# Comprovació de paràmetres
if [ "$#" -ne 1 ]; then
   echo "Error: S'ha de passar el nom del fitxer CSV com a argument"
   exit 1
fi

# Assignació del nom del fitxer CSV a una variable
CSV_FILE="$1"

# Comprovació d'existència del fitxer CSV
if [ ! -f "$CSV_FILE" ]; then
   echo "Error: El fitxer $CSV_FILE no existeix"
   exit 1
fi

# Creació del fitxer de logs si no existeix
LOG_FILE="logs.txt"
if [ ! -f "$LOG_FILE" ]; then
   touch "$LOG_FILE"
fi

# Lectura del fitxer CSV i creació dels usuaris
while IFS=, read -r user shell home password email; do
   # Comprovem si l'usuari ja existeix
   if id "$user" &>/dev/null; then
       echo "Usuari $user ja existent al sistema"
       echo "Usuari $user ja existent al sistema" >> "$LOG_FILE"
   else
       # Creació de l'usuari
       sudo useradd -m -s "$shell" -d "$home" -p "$password" -c "$email" "$user"
       echo "Usuari $user donat d'alta al sistema"
       echo "Usuari $user donat d'alta al sistema" >> "$LOG_FILE"
   fi
done < "$CSV_FILE"