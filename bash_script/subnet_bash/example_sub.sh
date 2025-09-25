#!/bin/bash

# Función para mostrar mensajes de bienvenida
show_welcome() {
    echo " "
    echo "=============================================="
    echo "Welcome to the IPv4 Subnetting Calculator"
    echo "=============================================="
    echo " "
}

# Expresiones regulares para clasificación de IPv4
REGEX_CLASS_A='^(0|1[0-9]{0,2}|12[0-6])(\.(25[0-5]|2[0-4][0-9]|1?[0-9]{1,2})){3}$'
REGEX_CLASS_B='^(12[8-9]|1[3-8][0-9]|19[0-1])(\.(25[0-5]|2[0-4][0-9]|1?[0-9]{1,2})){3}$'
REGEX_CLASS_C='^(19[2-9]|2[0-1][0-9]|22[0-3])(\.(25[0-5]|2[0-4][0-9]|1?[0-9]{1,2})){3}$'
REGEX_CLASS_D='^(22[4-9]|23[0-9])(\.(25[0-5]|2[0-4][0-9]|1?[0-9]{1,2})){3}$'
REGEX_CLASS_E='^(24[0-9]|25[0-5])(\.(25[0-5]|2[0-4][0-9]|1?[0-9]{1,2})){3}$'
REGEX_LOOPBACK='^127(\.(25[0-5]|2[0-4][0-9]|1?[0-9]{1,2})){3}$'
REGEX_PRIVATE_A='^10(\.(25[0-5]|2[0-4][0-9]|1?[0-9]{1,2})){3}$'
REGEX_PRIVATE_B='^172\.(1[6-9]|2[0-9]|3[0-1])(\.(25[0-5]|2[0-4][0-9]|1?[0-9]{1,2})){2}$'
REGEX_PRIVATE_C='^192\.168(\.(25[0-5]|2[0-4][0-9]|1?[0-9]{1,2})){2}$'

# Función para clasificar la IP
classify_ip() {
    local ip=$1

    if [[ $ip =~ $REGEX_LOOPBACK ]]; then
        echo "Loopback (127.0.0.0/8)"
    elif [[ $ip =~ $REGEX_PRIVATE_A ]]; then
        echo "Private Class A (10.0.0.0/8)"
    elif [[ $ip =~ $REGEX_PRIVATE_B ]]; then
        echo "Private Class B (172.16.0.0/12)"
    elif [[ $ip =~ $REGEX_PRIVATE_C ]]; then
        echo "Private Class C (192.168.0.0/16)"
    elif [[ $ip =~ $REGEX_CLASS_A ]]; then
        echo "Public Class A (1.0.0.0 - 126.255.255.255)"
    elif [[ $ip =~ $REGEX_CLASS_B ]]; then
        echo "Public Class B (128.0.0.0 - 191.255.255.255)"
    elif [[ $ip =~ $REGEX_CLASS_C ]]; then
        echo "Public Class C (192.0.0.0 - 223.255.255.255)"
    elif [[ $ip =~ $REGEX_CLASS_D ]]; then
        echo "Class D Multicast (224.0.0.0 - 239.255.255.255)"
    elif [[ $ip =~ $REGEX_CLASS_E ]]; then
        echo "Class E Experimental (240.0.0.0 - 255.255.255.255)"
    else
        echo "Unknown IP class"
    fi
}

# Funcion para validar CIDR
validate_cidr() {
    local cidr=$1
    if [[ $cidr =~ ^[0-9]+$ ]] && [ $cidr -ge 0 ] && [ $cidr -le 32 ]; then
        return 0
    else
        return 1
    fi
}

# Función para convertir IP a número de 32 bits
ip_to_num() {
    local ip=$1
    IFS='.' read -r o1 o2 o3 o4 <<< "$ip"
    echo $(( (o1 << 24) + (o2 << 16) + (o3 << 8) + o4 ))
}

# Funcion para convertir IP a numero de 32 bits
ip_to_num() {
    local ip=$1
    IFS='.' read -r o1 o2 o3 o4 <<< "$ip"
    echo $(( (o1 << 24) + (o2 << 16) + (o3 << 8) + o4 ))
}

# Función para convertir número a IP
num_to_ip() {
    local num=$1
    printf "%d.%d.%d.%d" \
        $(( (num >> 24) & 0xFF )) \
        $(( (num >> 16) & 0xFF )) \
        $(( (num >>  8) & 0xFF )) \
        $((  num        & 0xFF ))
}

# Funcion mejorada para calcular informacionn de red
calculate_network() {
    local ip=$1
    local cidr=$2

    # Caso especial para CIDR 0 (red 0.0.0.0/0)
    if [ "$cidr" -eq 0 ]; then
        echo "0.0.0.0/0"
        echo "0.0.0.0"
        echo "255.255.255.255"
        echo "4294967294"  # 2^32 - 2
        echo "0.0.0.1"
        echo "255.255.255.254"
        return
    fi

    local ip_num=$(ip_to_num "$ip")
    local mask_num=$(( 0xFFFFFFFF << (32 - cidr) & 0xFFFFFFFF ))
    local net_num=$(( ip_num & mask_num ))
    local broadcast_num=$(( net_num | ~mask_num & 0xFFFFFFFF ))

    # Manejo especial para diferentes CIDRs
    if [ "$cidr" -eq 32 ]; then
        # Host único (/32)
        echo "$(num_to_ip $net_num)/32"
        echo "255.255.255.255"
        echo "$(num_to_ip $net_num)"  # Broadcast igual a la IP
        echo "1"                      # Solo 1 host (él mismo)
        echo "$(num_to_ip $net_num)"  # Primer host
        echo "$(num_to_ip $net_num)"  # Último host
    elif [ "$cidr" -eq 31 ]; then
        # Red punto a punto (/31)
        echo "$(num_to_ip $net_num)/31"
        echo "255.255.255.254"
        echo "$(num_to_ip $broadcast_num)"
        echo "2"                      # 2 hosts (RFC 3021)
        echo "$(num_to_ip $net_num)"     # Primer host
        echo "$(num_to_ip $broadcast_num)" # Último host
    elif [ "$cidr" -le 30 ]; then
        # Redes normales (/0 a /30)
        local hosts_available=$(( (1 << (32 - cidr)) - 2 ))
        local first_host=$(( net_num + 1 ))
        local last_host=$(( broadcast_num - 1 ))

        echo "$(num_to_ip $net_num)/$cidr"
        echo "$(num_to_ip $mask_num)"
        echo "$(num_to_ip $broadcast_num)"
        echo "$hosts_available"
        echo "$(num_to_ip $first_host)"
        echo "$(num_to_ip $last_host)"
    fi
}

# Función principal para subnetting
perform_subnetting() {
    local network_ip=$1
    local original_cidr=$2
    local num_subnets=$3

    # Calcular nuevos bits de máscara
    local new_cidr=$(( original_cidr + $(echo "l($num_subnets)/l(2)" | bc -l | awk '{print int($1)+1}') ))

    # Calcular el tamaño de cada subred
    local subnet_size=$(( 1 << (32 - new_cidr) ))

    # Convertir IP de red a número
    local net_num=$(ip_to_num "$network_ip")

    echo "=============================================="
    echo "Subnetting Results for $network_ip/$original_cidr"
    echo "Creating $num_subnets subnets with /$new_cidr mask"
    echo "=============================================="
    echo ""

    # Generar cada subred
    for ((i=0; i<num_subnets; i++)); do
        local subnet_start_num=$(( net_num + (i * subnet_size) ))

        # Calcular información de la subred
        read subnet_network subnet_mask subnet_broadcast hosts_available subnet_first_host subnet_last_host <<< \
            $(calculate_network "$(num_to_ip $subnet_start_num)" "$new_cidr")

        echo "Subnet $((i+1)): $subnet_network"
        echo "----------------------------------------------"
        echo "Network:    $subnet_network"
        echo "Netmask:    $subnet_mask"
        echo "Broadcast:  $subnet_broadcast"
        echo "First Host: $subnet_first_host"
        echo "Last Host:  $subnet_last_host"
        echo "Hosts:      $hosts_available"
        echo ""
    done
}

# Función para solicitar entrada al usuario
get_user_input() {
    while true; do
        read -p "Enter the IPv4 address (e.g., 192.168.1.0): " ip
        if [[ $ip =~ ^([0-9]{1,3}\.){3}[0-9]{1,3}$ ]]; then
            # Validar cada octeto
            IFS='.' read -r o1 o2 o3 o4 <<< "$ip"
            valid=true
            for octet in $o1 $o2 $o3 $o4; do
                if [[ $octet -lt 0 || $octet -gt 255 ]]; then
                    valid=false
                    break
                fi
            done
            if $valid; then
                break
            else
                echo "Error: Each octet must be between 0 and 255."
            fi
        else
            echo "Error: Invalid IPv4 format. Please try again."
        fi
    done

    while true; do
        read -p "Enter the CIDR notation (e.g., 24 for /24): " cidr
        if validate_cidr "$cidr"; then
            break
        else
            echo "Error: CIDR must be an integer between 0 and 32."
        fi
    done

    while true; do
        read -p "Enter the number of subnets you want to create: " num_subnets
        if [[ $num_subnets =~ ^[0-9]+$ ]] && [ $num_subnets -ge 1 ]; then
            # Verificar si el número de subredes es posible
            max_subnets=$(( 2**(32 - cidr) ))
            if [ $num_subnets -gt $max_subnets ]; then
                echo "Error: Cannot create more than $max_subnets subnets from a /$cidr network."
            else
                break
            fi
        else
            echo "Error: Please enter a positive integer."
        fi
    done

    echo "$ip $cidr $num_subnets"
}

# Main program
show_welcome

# Obtener entrada del usuario
read ip cidr num_subnets <<< $(get_user_input)

# Mostrar información sobre la IP
ip_class=$(classify_ip "$ip")
echo ""
echo "=============================================="
echo "IP Information:"
echo "----------------------------------------------"
echo "IP Address:  $ip"
echo "IP Class:    $ip_class"
echo "CIDR:        /$cidr"
echo "Subnets:     $num_subnets"
echo "=============================================="
echo ""

# Calcular y mostrar información de la red principal
read network_id netmask broadcast hosts first_host last_host <<< $(calculate_network "$ip" "$cidr")
echo "Base Network Information:"
echo "----------------------------------------------"
echo "Network ID:  $network_id"
echo "Netmask:     $netmask"
echo "Broadcast:   $broadcast"
echo "Host Range:  $first_host - $last_host"
echo "Total Hosts: $hosts"
echo "=============================================="
echo ""

# Realizar el subnetting
perform_subnetting "$ip" "$cidr" "$num_subnets"
