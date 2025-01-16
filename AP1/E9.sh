# !/bin/bash
# Exercici 9 15/1/2025
# Autor: Alberto Trujillo
# Versió: 1.0

# Funció per comprovar si una nota és una D, C-, C+, B o A
comprova_nota() {
    local nota=$1
    if (( $nota >= 0 && $nota <= 10 )); then
        if (( $nota >= 0 && $nota <= 2 )); then
            echo "La nota és una D"
        elif (( $nota >= 3 && $nota <= 4 )); then
            echo "La nota és una C-"
        elif (( $nota >= 5 && $nota <= 6 )); then
            echo "La nota és una C+"
        elif (( $nota >= 7 && $nota <= 8 )); then
            echo "La nota és una B"
        else
            echo "La nota és una A"
        fi
    else
        echo "Error: La nota ha de ser un nombre entre 0 i 10."
    fi

}

# Demanem la nota
echo "Introdueix la nota: "
read nota

# Comprovem la nota
comprova_nota $nota