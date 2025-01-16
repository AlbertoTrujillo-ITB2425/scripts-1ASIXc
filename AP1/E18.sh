#!/bin/bash
# Script per obtenir informació de les instàncies EC2 i guardar-la en un fitxer CSV
# Autor: Alberto Trujillo
# Exercici 18 15/1/2025
# Versió: 1.1
# Ús: ./E18.sh

# Definir la variable de la regió
REGION="us-west-2" # Substitueix per la regió que necessites

# Comprovació de les eines necessàries
for cmd in aws jq; do
    if ! command -v "$cmd" &> /dev/null; then
        echo "$cmd no trobat. Instal·la $cmd abans de continuar."
        exit 1
    fi
done

OUTPUT_FILE="ec2_instances.csv"

# Crear fitxer CSV amb capçalera
echo "InstanceID,Status,Type,Name" > "$OUTPUT_FILE"

# Comprovar l'autenticació AWS abans d'obtenir dades
aws sts get-caller-identity &> /dev/null
if [ $? -ne 0 ]; then
    echo "Error d'autenticació AWS. Comprova les teves credencials."
    exit 1
fi

# Obtenir dades i escriure-les al fitxer
aws ec2 describe-instances --region "$REGION" \
    --query "Reservations[].Instances[].[InstanceId,State.Name,InstanceType,Tags[?Key=='Name'].Value | [0]]" \
    --output json | jq -r '.[] | @csv' >> "$OUTPUT_FILE"

# Comprovació de l'èxit de l'operació
if [ $? -eq 0 ]; then
    echo "Dades desades a $OUTPUT_FILE"
else
    echo "Error en obtenir informació d'instàncies EC2."
    exit 1
fi
