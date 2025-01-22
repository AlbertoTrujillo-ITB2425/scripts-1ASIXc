#!/bin/bash

# Script Calculadora d'Inversions
# Aquest script calcula el benefici o la pèrdua per a qualsevol inversió, incloent comissions,
# impostos i diferents opcions de venda.

# Funció per formatar números amb dos decimals
formatar_numero() {
  LC_NUMERIC=C printf "%.2f" "$1" | sed 's/\./,/'
}

# Funció per assegurar que s'utilitza el punt decimal per als càlculs
assegurar_punt_decimal() {
  echo "$1" | sed 's/,/\./'
}

# Funció per calcular el benefici o la pèrdua
calcular_benefici_perdua() {
  local preu_compra=$(assegurar_punt_decimal "$1")
  local preu_venda=$(assegurar_punt_decimal "$2")
  local quantitat=$(assegurar_punt_decimal "$3")
  local comissio_compra=$(assegurar_punt_decimal "$4")
  local comissio_venda=$(assegurar_punt_decimal "$5")
  local opcio_venda="$6"

  total_compra=$(echo "$preu_compra * $quantitat + $comissio_compra" | bc -l)
  total_venda=$(echo "$preu_venda * $quantitat - $comissio_venda" | bc -l)

  if (( $(echo "$total_venda > $total_compra" | bc -l) )); then
    benefici=$(echo "$total_venda - $total_compra" | bc -l)
    benefici_formatat=$(formatar_numero $benefici)
    echo -e "\n\e[1;32mBenefici Brut: \$${benefici_formatat}\e[0m"
    calcular_impostos "$benefici" "$opcio_venda"
  elif (( $(echo "$total_venda < $total_compra" | bc -l) )); then
    perdua=$(echo "$total_compra - $total_venda" | bc -l)
    perdua_formatada=$(formatar_numero $perdua)
    echo -e "\n\e[1;31mPèrdua: \$${perdua_formatada}\e[0m"
  else
    echo -e "\n\e[1;33mNi benefici ni pèrdua. Els imports totals de compra i venda són iguals.\e[0m"
  fi
}

# Funció per calcular impostos basats en el benefici i l'opció de venda
calcular_impostos() {
  local benefici=$1
  local opcio_venda=$2
  local impost=0

  # Càlcul d'impostos per a Espanya 2025
  if [ "$opcio_venda" == "fiat" ]; then
    if (( $(echo "$benefici <= 6000" | bc -l) )); then
      impost=$(echo "$benefici * 0.19" | bc -l)
    elif (( $(echo "$benefici > 6000 && $benefici <= 50000" | bc -l) )); then
      impost=$(echo "6000 * 0.19 + ($benefici - 6000) * 0.21" | bc -l)
    elif (( $(echo "$benefici > 50000 && $benefici <= 200000" | bc -l) )); then
      impost=$(echo "6000 * 0.19 + 44000 * 0.21 + ($benefici - 50000) * 0.23" | bc -l)
    else
      impost=$(echo "6000 * 0.19 + 44000 * 0.21 + 150000 * 0.23 + ($benefici - 200000) * 0.26" | bc -l)
    fi
  elif [ "$opcio_venda" == "stablecoin" ]; then
    impost=$(echo "$benefici * 0.19" | bc -l)  # Suposant un 19% fix per a operacions amb stablecoins
  else
    impost=0  # Sense impost immediat per a operacions cripto-a-cripto
  fi

  impost_formatat=$(formatar_numero $impost)
  echo -e "\n\e[1;34mImpostos Estimats: \$${impost_formatat}\e[0m"

  # Càlcul del benefici net després d'impostos
  benefici_net=$(echo "$benefici - $impost" | bc -l)
  benefici_net_formatat=$(formatar_numero $benefici_net)
  echo -e "\n\e[1;32mBenefici Net després d'impostos: \$${benefici_net_formatat}\e[0m"
}

# Funció per demanar la moneda específica
demanar_moneda_especifica() {
  local tipus=$1
  local moneda=""

  case $tipus in
    fiat)
      while [[ ! $moneda =~ ^(USD|EUR|GBP|JPY|CHF)$ ]]; do
        read -p $'\e[1;33mIntrodueix la moneda fiat (USD/EUR/GBP/JPY/CHF): \e[0m' moneda
        moneda=${moneda^^}  # Convertir a majúscules
      done
      ;;
    stablecoin)
      while [[ ! $moneda =~ ^(USDT|USDC|DAI|BUSD)$ ]]; do
        read -p $'\e[1;33mIntrodueix la stablecoin (USDT/USDC/DAI/BUSD): \e[0m' moneda
        moneda=${moneda^^}  # Convertir a majúscules
      done
      ;;
    crypto)
      while [[ ! $moneda =~ ^(BTC|ETH)$ ]]; do
        read -p $'\e[1;33mIntrodueix la criptomoneda (BTC/ETH): \e[0m' moneda
        moneda=${moneda^^}  # Convertir a majúscules
      done
      ;;
  esac

  echo $moneda
}

# Demanar dades a l'usuari
read -p $'\e[1;33mIntrodueix el preu de compra per unitat: \e[0m' preu_compra
read -p $'\e[1;33mIntrodueix el preu de venda per unitat: \e[0m' preu_venda
read -p $'\e[1;33mIntrodueix la quantitat: \e[0m' quantitat
read -p $'\e[1;33mIntrodueix la comissió de compra: \e[0m' comissio_compra
read -p $'\e[1;33mIntrodueix la comissió de venda: \e[0m' comissio_venda

# Demanar l'opció de venda i la moneda específica
while true; do
  read -p $'\e[1;33mIntrodueix l opció de venda (fiat/stablecoin/crypto): \e[0m' opcio_venda
  opcio_venda=${opcio_venda,,}  # Convertir a minúscules
  if [[ $opcio_venda =~ ^(fiat|stablecoin|crypto)$ ]]; then
    moneda_especifica=$(demanar_moneda_especifica $opcio_venda)
    break
  else
    echo -e "\e[1;31mOpció no vàlida. Si us plau, introdueix 'fiat', 'stablecoin' o 'crypto'.\e[0m"
  fi
done

# Validar les dades introduïdes
if [[ ! $preu_compra =~ ^[0-9]+([,.][0-9]+)?$ ]] || 
   [[ ! $preu_venda =~ ^[0-9]+([,.][0-9]+)?$ ]] || 
   [[ ! $quantitat =~ ^[0-9]+([,.][0-9]+)?$ ]] ||
   [[ ! $comissio_compra =~ ^[0-9]+([,.][0-9]+)?$ ]] ||
   [[ ! $comissio_venda =~ ^[0-9]+([,.][0-9]+)?$ ]]; then
  echo -e "\e[1;31mDades no vàlides. Si us plau, introdueix valors numèrics vàlids (utilitza , o . per als decimals).\e[0m"
  exit 1
fi

# Formatar i mostrar els valors introduïts
preu_compra_formatat=$(formatar_numero $(assegurar_punt_decimal $preu_compra))
preu_venda_formatat=$(formatar_numero $(assegurar_punt_decimal $preu_venda))
quantitat_formatada=$(formatar_numero $(assegurar_punt_decimal $quantitat))
comissio_compra_formatada=$(formatar_numero $(assegurar_punt_decimal $comissio_compra))
comissio_venda_formatada=$(formatar_numero $(assegurar_punt_decimal $comissio_venda))

echo -e "\n\e[1;36mDetalls de la Transacció:\e[0m"
echo -e "Preu de Compra: \$${preu_compra_formatat}"
echo -e "Preu de Venda: \$${preu_venda_formatat}"
echo -e "Quantitat: ${quantitat_formatada}"
echo -e "Comissió de Compra: \$${comissio_compra_formatada}"
echo -e "Comissió de Venda: \$${comissio_venda_formatada}"
echo -e "Opció de Venda: ${opcio_venda} (${moneda_especifica})"

# Calcular i mostrar el benefici o la pèrdua
calcular_benefici_perdua "$preu_compra" "$preu_venda" "$quantitat" "$comissio_compra" "$comissio_venda" "$opcio_venda"
