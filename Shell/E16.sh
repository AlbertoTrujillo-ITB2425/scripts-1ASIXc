#!/bin/bash
# Script per comprovar si l'usuari messi existeix al sistema
# Autor: Alberto Trujillo
# Exercici 16 15/1/2025
# Versio: 1.0
# Us: ./E16.sh

# Comprovem si l'usuari messi existeix
grep -q "^messi:" /etc/passwd
#   - grep: Busca patrones en un archivo.
#   - -q: Silencia la salida, solo devuelve el código de salida.
#   - "^messi:": Busca líneas que comiencen con "messi:".
#   - /etc/passwd: Archivo que contiene información sobre los usuarios.

if [ $? -eq 0 ]; then
    # Si grep devuelve 0 (verdadero), el usuario existe.
    echo "L'usuari messi existeix al sistema."
else
    # Si grep devuelve 1 (falso), el usuario no existe.
    echo "L'usuari messi no existeix al sistema."
fi

exit 0