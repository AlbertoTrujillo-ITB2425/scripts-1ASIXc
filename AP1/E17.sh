#!/bin/bash
# Script per mostrar si estem executant com a superusuari root
# Autor: Alberto Trujillo
# Exercici 17 15/1/2025
# Versio: 1.0
# Us: ./E17.sh

# Comprova si l'usuari és superusuari root
if [ "$(id -u)" -ne 0 ]; then
    echo "Aquest script s'ha d'executar amb superusuari root."
    exit 1
fi
# Comprova si et trobes executant l'script com a superusuari root
if [ "$(id -u)" -eq 0 ]; then
    echo "Superusuari root ja està en execució."
else
    echo "Superusuari root no està en
    execució."
fi
