#!/bin/bash
# Script per mostrar si l'usuari messi existeix al sistema
# Autor: Alberto Trujillo
# Exercici 16 15/1/2025
# Versio: 1.0
# Us: ./E16.sh

# Comprovem si l'usuari messi existeix
 grep -q "^messi:" /etc/passwd
 if [ $? -eq 0 ]; then
     echo "L'usuari messi existeix al sistema."
 else
     echo "L'usuari messi no existeix al sistema."
    fi
exit 0
