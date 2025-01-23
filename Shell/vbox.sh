#!/bin/bash
#Script Realitzat per Alberto Trujillo a la data 26/9/2024
# Bucle infinit per mostrar el menú fins que l'usuari decideixi sortir.
while true; do
    # Mostra les opcions del menú.
    echo "Selecciona una opció:"
    echo "1) Llistar màquines"
    echo "2) Mostrar info W11"
    echo "3) Mostrar info Ubuntu"
    echo "4) Arrencar Ubuntu"
    echo "5) Arrencar W11"
    echo "6) Apagar Ubuntu"
    echo "7) Apagar W11"
    echo "8) Exportar Ubuntu"
    echo "9) Exportar W11"
    echo "10) Sortir"
    
    # Llegeix l'opció seleccionada per l'usuari.
    read -p "Opció: " opcio
    
    # Executa l'acció corresponent segons l'opció seleccionada.
    case $opcio in
        1) 
            # Llista totes les màquines virtuals disponibles.
            VBoxManage list vms
            if [ $? -eq 0 ]; then
                echo "S'han llistat totes les màquines disponibles en VBox."
            else
                echo "Error al llistar les màquines. Revisa VBoxManage."
            fi
            ;;
        2) 
            # Mostra la informació de la màquina W11.
            VBoxManage showvminfo AlbertoW11
            if [ $? -eq 0 ]; then
                echo "Aquí tens la informació de la màquina W11."
            else
                echo "Error al mostrar la informació de W11."
            fi
            ;;
        3)  
            # Mostra la informació de la màquina Ubuntu.
            VBoxManage showvminfo AlbertoUbuntu
            if [ $? -eq 0 ]; then
                echo "Aquí tens la informació de la màquina Ubuntu."
            else
                echo "Error al mostrar la informació d'Ubuntu."
            fi
            ;;
        4)  
            # Arrenca la màquina Ubuntu en mode sense capçalera.
            VBoxManage startvm AlbertoUbuntu --type headless
            if [ $? -eq 0 ]; then
                echo "La màquina Ubuntu està en marxa!"
            else
                echo "Error al arrencar Ubuntu."
            fi
            ;;
        5)  
            # Arrenca la màquina W11 en mode sense capçalera.
            VBoxManage startvm AlbertoW11 --type headless
            if [ $? -eq 0 ]; then
                echo "La màquina W11 està en marxa!"
            else
                echo "Error al arrencar W11."
            fi
            ;;
        6)  
            # Pregunta per confirmació abans d'apagar Ubuntu.
            read -p "Estàs segur que vols apagar Ubuntu? (s/n): " confirmar
            if [ "$confirmar" == "s" ]; then
                VBoxManage controlvm AlbertoUbuntu poweroff
                if [ $? -eq 0 ]; then
                    echo "La màquina Ubuntu s'ha apagat."
                else
                    echo "Error al apagar Ubuntu."
                fi
            else
                echo "Operació cancel·lada."
            fi
            ;;
        7)  
            # Pregunta per confirmació abans d'apagar W11.
            read -p "Estàs segur que vols apagar W11? (s/n): " confirmar
            if [ "$confirmar" == "s" ]; then
                VBoxManage controlvm AlbertoW11 poweroff
                if [ $? -eq 0 ]; then
                    echo "La màquina W11 ha sigut apagada."
                else
                    echo "Error al apagar W11."
                fi
            else
                echo "Operació cancel·lada."
            fi
            ;;
        8)  
            # Defineix la ruta d'exportació i comprova si el fitxer ja existeix.
            export_path="/home/alberto.trujillo.7e6/Escriptori/DADES/Alberto/OVA/AlbertoUbuntu1.ova"
            if [ -f "$export_path" ]; then
                # Pregunta per confirmació si el fitxer ja existeix.
                read -p "El fitxer ja existeix. Vols sobreescriure'l? (s/n): " confirmar
                if [ "$confirmar" != "s" ]; then
                    echo "Operació cancel·lada."
                    continue
                fi
            fi
            # Exporta la màquina Ubuntu.
            VBoxManage export AlbertoUbuntu --output "$export_path"
            if [ $? -eq 0 ]; then
                echo "Ubuntu ha sigut exportat."
            else
                echo "Error al exportar Ubuntu."
            fi
            ;;
        9)  
            # Defineix la ruta d'exportació i comprova si el fitxer ja existeix.
            export_path="/home/alberto.trujillo.7e6/Escriptori/DADES/Alberto/OVA/AlbertoW11_1.ova"
            if [ -f "$export_path" ]; then
                # Pregunta per confirmació si el fitxer ja existeix.
                read -p "El fitxer ja existeix. Vols sobreescriure'l? (s/n): " confirmar
                if [ "$confirmar" != "s" ]; then
                    echo "Operació cancel·lada."
                    continue
                fi
            fi
            # Exporta la màquina W11.
            VBoxManage export AlbertoW11 --output "$export_path"
            if [ $? -eq 0 ]; then
                echo "W11 ha sigut exportat."
            else
                echo "Error al exportar W11."
            fi
            ;;
        10)
            # Opció per sortir del bucle i finalitzar el script.
            echo "Sortint..."
            break
            ;;
        *) 
            # Missatge d'error per opcions no vàlides.
            echo "Opció no vàlida. Si us plau, selecciona una opció del 1 al 10."
            ;;
    esac
done
