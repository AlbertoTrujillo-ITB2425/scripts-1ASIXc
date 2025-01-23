+#!/bin/bash

# Crear logs si no existen
touch cpu_usage.log
touch gpu_usage.log
touch mem_usage.log
touch swap_usage.log
touch disk_usage.log
touch sistema.log

# Monitoritzar sistema cada 3 minuts
while true
do
    # Monitoritzar el sistema general
    echo "Sistema general: $(uptime -p | awk '{print $2}')" >> sistema.log
    echo "Monitorització completada. Esperant 3 minuts..."  # Mensaje en la terminal
    sleep 3m

    # Monitoritzar memòria RAM + SWAP
    mem_usage=$(free -m | grep Mem | awk '{print $3/$2 * 100.0}')
    swap_usage=$(free -m | grep Swap | awk '{print $3/$2 * 100.0}')
    echo "Memòria RAM Usage: $mem_usage%" >> mem_usage.log
    echo "SWAP Usage: $swap_usage%" >> swap_usage.log

    # Monitoritzar CPU
    cpu_usage=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1"%"}')
    echo "CPU Usage: $cpu_usage" >> cpu_usage.log

    # Monitoritzar GPU (si nvidia-smi está disponible)
    if command -v nvidia-smi &> /dev/null
    then
        gpu_usage=$(nvidia-smi --query-gpu=utilization.gpu --format=csv,noheader,nounits)
        echo "GPU Usage: $gpu_usage%" >> gpu_usage.log
    else
        echo "GPU Usage: No GPU found" >> gpu_usage.log
    fi

    # Monitoritzar disc durable
    disk_usage=$(df -h / | awk 'NR==2{print $5}')
    echo "Espai de disc durable: $disk_usage" >> disk_usage.log

    # Monitoritzar el nombre de processos activos
    process_count=$(ps -ef | wc -l)
    echo "Processos actius: $process_count" >> sistema.log

    # Imprimir mensaje de espera en la terminal
    echo "Monitorització completada. Esperant 3 minuts..."

    # Esperar 3 minuts abans de la següent iteració
    sleep 3m
done
