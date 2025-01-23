#!/bin/bash
# Script per crear màquines a AWS a partir d'un fitxer CSV
# Autor: Alberto Trujillo
# Exercici 19 16/1/2025
# Versio: 1.0
# Us: ./E19.sh

# Defineix el fitxer CSV que conté la informació de les màquines a crear
CSV_FILE="maquines.csv"

# Asume que el fitxer CSV té la següent estructura:
# instance_type,ami,security_group,instance_label

# Llegeix el fitxer CSV línia a línia i crea una instància per cada línia
while IFS=, read -r instance_type ami security_group instance_label
do
    # Imprimeix un missatge indicant que s'està creant la màquina
    echo "Creant la màquina $instance_label..."

    # Utilitza la CLI d'AWS per crear la instància
    aws ec2 run-instances \
        --image-id "$ami" \  # ID de la AMI (imatge de màquina)
        --count 1 \        # Nombre d'instàncies a crear
        --instance-type "$instance_type" \  # Tipus d'instància (t2.micro, m5.large, etc.)
        --security-group-ids "$security_group" \  # ID del grup de seguretat
        --tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value="$instance_label"}]' \  # Etiqueta la instància amb el nom especificat

done < "$CSV_FILE"

echo "Màquines creades correctament"