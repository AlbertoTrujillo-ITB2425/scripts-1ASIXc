#!/bin/bash
clear

# Definir colores
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m' # Sin color

# Función para pinguear toda la red local
ping_network() {
    local ip_base=$(ip route | grep -oP 'src \K[\d.]+')  # Obtener IP local
    ip_base=$(echo "$ip_base" | sed 's/\.[0-9]*$//')     # Eliminar último octeto
    echo -e "${YELLOW}Haciendo ping a la red ${ip_base}.0/24...${NC}"

    for i in {1..254}; do
        ping -c 1 -W 1 "$ip_base.$i" &> /dev/null && echo -e "${GREEN}Host $ip_base.$i está activo.${NC}" &
    done
    wait
}

# Función para mostrar información de red
network_info() {
    echo -e "${YELLOW}Información de red:${NC}"
    ip addr show
}

# Función para reiniciar servicio de red
restart_network() {
    echo -e "${YELLOW}Reiniciando servicio de red...${NC}"
    sudo systemctl restart NetworkManager && echo -e "${GREEN}Servicio de red reiniciado.${NC}" || echo -e "${RED}Error al reiniciar el servicio.${NC}"
}

# Función para verificar conectividad a Internet
check_internet() {
    echo -e "${YELLOW}Comprobando conectividad a Internet...${NC}"
    if ping -c 3 8.8.8.8 &> /dev/null; then
        echo -e "${GREEN}Conectividad a Internet OK.${NC}"
    else
        echo -e "${RED}No hay conectividad a Internet.${NC}"
    fi
}

# Función para mostrar uso de CPU
cpu_usage() {
    echo -e "${YELLOW}Uso de CPU:${NC}"
    top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1"% utilizado"}'
}

# Función para mostrar temperatura de la CPU
cpu_temperature() {
    if command -v sensors &> /dev/null; then
        echo -e "${YELLOW}Temperatura de la CPU:${NC}"
        sensors | grep 'Core'
    else
        echo -e "${RED}sensors no está instalado. Instala 'lm-sensors' para esta función.${NC}"
    fi
}

# Función para matar procesos que consumen más CPU
kill_high_cpu_processes() {
    echo -e "${YELLOW}Procesos que consumen más CPU:${NC}"
    ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%cpu | head -n 6

    echo -n "Introduce el PID del proceso a matar (o presiona Enter para omitir): "
    read pid
    if [ ! -z "$pid" ]; then
        sudo kill -9 $pid && echo -e "${GREEN}Proceso $pid terminado.${NC}" || echo -e "${RED}Error al terminar el proceso.${NC}"
    else
        echo -e "${YELLOW}No se ha matado ningún proceso.${NC}"
    fi
}

# Función para limpiar la caché de la memoria
clear_memory_cache() {
    echo -e "${YELLOW}Limpiando caché de la memoria...${NC}"
    sudo sync; sudo sysctl -w vm.drop_caches=3
    echo -e "${GREEN}Caché de la memoria limpiada.${NC}"
}

# Función para desactivar servicios innecesarios
disable_unnecessary_services() {
    echo -e "${YELLOW}Servicios innecesarios desactivados:${NC}"
    sudo systemctl stop cups-browsed && echo -e "${GREEN}Servicio cups-browsed detenido.${NC}"
    sudo systemctl stop bluetooth && echo -e "${GREEN}Servicio bluetooth detenido.${NC}"
}

# Función para eliminar archivos temporales
clean_temp_files() {
    echo -e "${YELLOW}Eliminando archivos temporales...${NC}"
    sudo rm -rf /tmp/* && echo -e "${GREEN}Archivos temporales eliminados.${NC}"
}

while :
do
    clear
    echo -e "${CYAN}=====================================${NC}"
    echo -e "${YELLOW}        Escoja una opción            ${NC}"
    echo -e "${CYAN}=====================================${NC}"
    echo -e "${GREEN}1) ¿Quién soy?${NC}"
    echo -e "${GREEN}2) ¿Cuánto espacio tengo?${NC}"
    echo -e "${GREEN}3) ¿Qué es esto? (versión del kernel)${NC}"
    echo -e "${GREEN}4) Pinguear toda la red local${NC}"
    echo -e "${GREEN}5) Mostrar información del sistema${NC}"
    echo -e "${GREEN}6) Mostrar uso de memoria RAM${NC}"
    echo -e "${GREEN}7) Mostrar procesos activos${NC}"
    echo -e "${GREEN}8) Mostrar información de red${NC}"
    echo -e "${GREEN}9) Reiniciar servicio de red${NC}"
    echo -e "${GREEN}10) Comprobar conectividad a Internet${NC}"
    echo -e "${GREEN}11) Monitorizar uso de CPU${NC}"
    echo -e "${GREEN}12) Monitorizar temperatura de CPU${NC}"
    echo -e "${GREEN}13) Matar procesos que consumen más CPU${NC}"
    echo -e "${GREEN}14) Limpiar caché de memoria${NC}"
    echo -e "${GREEN}15) Desactivar servicios innecesarios${NC}"
    echo -e "${GREEN}16) Limpiar archivos temporales${NC}"
    echo -e "${GREEN}17) Salir${NC}"
    echo -e "${CYAN}=====================================${NC}"
    echo -n "Seleccione una opción [1 - 17]: "
    
    read opcion
    
    case $opcion in
        1)
            echo -e "${YELLOW}Este eres: $(whoami)${NC}"
            ;;
        2)
            echo -e "${YELLOW}Espacio disponible:${NC}"
            df -h
            ;;
        3)
            echo -e "${YELLOW}Versión del kernel: $(uname -r)${NC}"
            ;;
        4)
            ping_network
            ;;
        5)
            echo -e "${YELLOW}Información del sistema:${NC}"
            lsb_release -a
            ;;
        6)
            echo -e "${YELLOW}Uso de memoria RAM:${NC}"
            free -h
            ;;
        7)
            echo -e "${YELLOW}Procesos activos:${NC}"
            ps aux --sort=-%mem | head -n 10
            ;;
        8)
            network_info
            ;;
        9)
            restart_network
            ;;
        10)
            check_internet
            ;;
        11)
            cpu_usage
            ;;
        12)
            cpu_temperature
            ;;
        13)
            kill_high_cpu_processes
            ;;
        14)
            clear_memory_cache
            ;;
        15)
            disable_unnecessary_services
            ;;
        16)
            clean_temp_files
            ;;
        17)
            echo -e "${RED}Chao!${NC}"
            exit 1
            ;;
        *)
            echo -e "${RED}Opción inválida. Es tan difícil?${NC}"
            ;;
    esac
    
    echo
    echo -e "${CYAN}Presiona una tecla para continuar...${NC}"
    read -n 1
done
