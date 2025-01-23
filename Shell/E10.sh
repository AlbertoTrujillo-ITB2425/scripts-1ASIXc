#!/bin/bash
# Exercici 10 15/1/2025
# Autor: Alberto Trujillo
# Versió: 1.0

# Funció per comprovar si una nota és una D, C-, C+, B o A
comprova_nota() {
    # Variable local per emmagatzemar la nota
    local nota=$1

    # Estructura de decisió "case" per comparar la nota i mostrar el resultat
    case $nota in
        0|1|2)
            echo "La nota és una D"
            ;;
        3|4)
            echo "La nota és una C-"
            ;;
        5|6)
            echo "La nota és una C+"
            ;;
        7|8)
            echo "La nota és una B"
            ;;
        9|10)
            echo "La nota és una A"
            ;;
        *)
            # Opció per defecte si la nota no està entre 0 i 10
            echo "Error: La nota ha de ser un nombre entre 0 i 10."
            ;;
    esac
}

# Demanem a l'usuari que introdueixi la nota
echo "Introdueix la nota: "
read nota

# Invoquem la funció per comprovar la nota
comprova_nota $nota