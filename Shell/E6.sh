Fer un script que demani 2 nombres i mostri la seva suma, resta, multiplicació i divisió.

#!/bin/bash
#Exercici 6 15/1/2025
#Autor: Alberto Trujillo
#Versió: 1.0

# Demanem els dos nombres
echo "Introdueix el primer nombre: "
read num1
echo "Introdueix el segon nombre: "
read num2

# Realitzem les operacions
suma=$(($num1 + $num2))
# Fa la resta 
resta=$(($num1 - $num2))
# Fa la multiplicació
multiplicacio=$(($num1 * $num2))
# Fa la divisió 
divisio=$(($num1 / $num2))

# Mostrem els resultats de la suma 
echo "La suma dels dos nombres és: $suma"
# Mostrem els resultats de la resta
echo "La resta dels dos nombres és: $resta"
# Mostrem els resultats de la multplicació
echo "La multiplicació dels dos nombres és: $multiplicacio"
# Mostrem els resultats de la divisió 
echo "La divisió dels dos nombres és: $divisio"
