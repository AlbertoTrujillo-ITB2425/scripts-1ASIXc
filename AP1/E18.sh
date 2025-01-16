#!/bin/bash
# Script per obtenir informació de les instàncies EC2 i guardar-la en un fitxer CSV
# Autor: Alberto Trujillo
# Exercici 18 16/1/2025
# Versió: 1.0

# Defineix les variables per a AWS CLI
aws_region="us-east-1"
ec2_instance_state="running"

# Comprovació de les eines necessàries
for cmd in aws jq; do
    if ! command -v "$cmd" &> /dev/null; then
        echo "$cmd no trobat. Instal·la $cmd abans de continuar."
        exit 1
    fi
done

# Consulta AWS EC2 per obtenir totes les instàncies que estan operatives
aws ec2 describe-instances --region "$aws_region" --filters "Name=instance-state-name,Values=$ec2_instance_state" \
    --query 'Reservations[*].Instances[*].[InstanceId, State.Name, InstanceType, Tags[?Key==`Name`].Value | [0]]' --output json > ec2_instances_temp.json

# Comprovar si s'ha obtingut dades
if [ ! -s ec2_instances_temp.json ]; then
    echo "No s'han obtingut dades d'instàncies EC2. Comprova la teva configuració i regió."
    rm ec2_instances_temp.json
    exit 1
fi

# Crear fitxer CSV amb capçalera
OUTPUT_FILE="ec2_instances.csv"
echo "InstanceID,Status,Type,Name" > "$OUTPUT_FILE"

# Convertir les dades JSON a CSV i desar-les al fitxer
jq -r '.[] | map(tostring) | @csv' ec2_instances_temp.json >> "$OUTPUT_FILE"

# Comprovació de l'èxit de l'operació
if [ $? -eq 0 ]; then
    echo "Dades desades a $OUTPUT_FILE"
    rm ec2_instances_temp.json
else
    echo "Error en convertir informació d'instàncies EC2 a CSV."
    rm ec2_instances_temp.json
    exit 1
fi

echo "CSV generat amb les instàncies operatives en el entorn d'AWS"
