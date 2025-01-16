# !/bin/bash
# Script per crear màquines a AWS a partir d'un fitxer CSV
# Autor: Alberto Trujillo
# Exercici 19 16/1/2025
# Versió: 1.0
# Us: ./E19.sh

# Aquí, el fitxer CSV conté la informació necessària per crear les màquines
CSV_FILE="maquines.csv"

while IFS=, read -r instance_type ami security_group instance_label
do
    echo "Creant la màquina $instance_label..."

    # Creem la màquina
    aws ec2 run-instances \
        --image-id "$ami" \
        --count 1 \
        --instance-type "$instance_type" \
        --security-group-ids "$security_group" \
        --tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value="$instance_label"}]'

done < "$CSV_FILE"

echo "Màquines creades correctament"
