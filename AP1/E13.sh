#!/bin/bash
# Script per mostrar els usuaris del sistema amb accés a bash
# Autor: Alberto Trujillo
# Exercici 13 15/1/2/2025
# Versio: 1.0

# Obtenim la llista dels usuaris amb shell bash
# awk -F: '($7 == "/bin/bash" || $7 == "/bin/sh") {print $1}' /etc/passwd
#   - awk: Processa el fitxer línea a línea.
#   - -F: Defineix el separador de camps com a ':'.
#   - '$7 == "/bin/bash" || $7 == "/bin/sh"': Filtra les línies on el setè camp (shell) és bash o sh.
#   - {print $1}': Imprimeix el primer camp (nom d'usuari).
users=$(awk -F: '($7 == "/bin/bash" || $7 == "/bin/sh") {print $1}' /etc/passwd)

# Comprovam si hi ha usuaris disponibles
if [ -z "$users" ]; then
    echo "No hi ha usuaris amb accés a bash."
    exit 0
fi

# Mostrem la llista dels usuaris
echo "Llista dels usuaris del sistema amb accés a bash:"
echo "------------------------------"
echo "$users"
echo ""

# Demanem l'usuari a iniciar sessió
read -p "Introdueix l'usuari a iniciar sessió: " user

# Comprovem si l'usuari existeix a la llista obtinguda
if echo "$users" | grep -qw "$user"; then
   echo "Iniciant sessió amb l'usuari $user..."
   su - "$user"
else
   echo "L'usuari $user no existeix o no pot iniciar sessió."
fi

exit 0