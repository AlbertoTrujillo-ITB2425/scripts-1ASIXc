#!/bin/bash
# Script per fer una còpia de seguretat d'una carpeta
# Autor: Alberto Trujillo
# Exercici 16 15/1/2025
# Versio: 1.0
# Us: ./E16.sh <directori_a_copiar> <directori_desti>

# Comprovació de paràmetres
if [ $# -ne 2 ]; then
  echo "Usage: $0 <directori_a_copiar> <directori_desti>"
  exit 1
fi

# Assignació de variables
directori_a_copiar="$1"
directori_desti="$2"
data=$(date +%Y%m%d)
nom_fitxer="backup_$(basename $directori_a_copiar)_$data.tar.gz"

# Comprovació de si existeix el directori a copiar
if [ ! -d "$directori_a_copiar" ]; then
    echo "Error: El directori $directori_a_copiar no existeix"
    exit 1
    fi

# Comprovació de si ja existeix un fitxer amb el mateix nom
if [ -f "$directori_desti/$nom_fitxer" ]; then
    echo "Error: El fitxer $nom_fitxer ja existeix al directori $directori_desti"
    exit 2
fi

# Fer la còpia amb tar
tar -czf "$directori_desti/$nom_fitxer" "$directori_a_copiar"
echo "Còpia de seguretat feta correctament al fitxer $directori_desti/$nom_fitxer"
exit 0
