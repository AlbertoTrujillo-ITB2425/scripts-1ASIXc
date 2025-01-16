#!/bin/bash
# Script per mostrar el contingut d'un directori
# Autor: Alberto Trujillo
# Exercici 10 15/1/2025
# Versio: 1.0
# Us: ./E10.sh <nom_directori>

# Comprovem que s'ha passat un argument
if [ -z "$1" ]; then
  echo "Has d'introduir un nom de directori."
  exit 1
fi

# Comprovem si el directori existeix
if [ ! -d "$1" ]; then
  echo "El directori '$1' no existeix."
  exit 1
fi

# Funció per mostrar el contingut d'un directori i la seva categoria
mostrar_directori() {
  local dir="$1"
  echo "El contingut del directori $dir és:"
  ls -l "$dir"
  
  case "$dir" in
    */bin) echo "Conté binaris executables." ;;
    */lib) echo "Conté llibreries." ;;
    */etc) echo "Conté fitxers de configuració." ;;
    */var) echo "Conté fitxers variables." ;;
    *)     echo "No té una categoria definida." ;;
  esac
}

# Executar la funció
mostrar_directori "$1"

# Exit
exit 0
