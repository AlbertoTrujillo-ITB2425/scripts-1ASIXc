#!/bin/bash
#Exercici 7 15/1/2025
#Autor: Alberto Trujillo
#Versió: 1.0

# Demanem el nom del fitxer
echo "Introdueix el nom del fitxer: "
read nomfitxer

# Comprovem si el paràmetre és un fitxer
if [ ! -f "$nomfitxer" ]; then
    echo "Error: $nomfitxer no és un fitxer regular."
    echo "Us: $0 <nom_fitxer>"
    exit 1
fi

# Comprovem si el fitxer és regular
if ! [[ "$nomfitxer" =~ ^[a-zA-Z0-9._-]+$ ]]; then
    echo "Error: $nomfitxer no és un fitxer regular."
    echo "Us: $0 <nom_fitxer>"
    exit 1
fi
