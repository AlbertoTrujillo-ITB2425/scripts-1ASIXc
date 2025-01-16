#!/bin/bash
# Exercici 10 15/1/2025
# Autor: Alberto Trujillo
# Versió: 1.0

# Funció per comprovar si una nota és una D, C-, C+, B o A
comprova_nota() {
    local nota=$1
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
            echo "Error: La nota ha de ser un nombre entre 0 i 10."
            ;;
    esac
}

# Demanem la nota
echo "Introdueix la nota: "
read nota

# Comprovem la nota
comprova_nota $nota
