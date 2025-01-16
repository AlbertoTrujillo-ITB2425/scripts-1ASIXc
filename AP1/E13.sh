#!/bin/bash
# Script per mostrar els usuaris del sistema amb accés a bash
# Autor: Alberto Trujillo
# Exercici 13 15/1/2025
# Versio: 1.0

# Obtenim la llista dels usuaris amb shell bash
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

# Comprovem si l'usuari existeix
if echo "$users" | grep -qw "$user"; then
   echo "Iniciant sessió amb l'usuari $user..."
   su - "$user"
else
   echo "L'usuari $user no existeix o no pot iniciar sessió."
fi

exit 0
