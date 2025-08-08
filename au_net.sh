#!/bin/bash

# define

# include 

if [ -f "au_wifi.sh" ]; then
    source au_wifi.sh
fi

# start

au.net.ip(){
    iface=$(nmcli device status | awk '$2 == "ethernet" && $3 == "connected" {print $1}')
    nmcli -g IP4.ADDRESS device show "$iface" | cut -d/ -f1
}

au.net.gateway(){
    iface=$(nmcli device status | awk '$2 == "ethernet" && $3 == "connected" {print $1}')
    nmcli -g IP4.GATEWAY device show "$iface"
}

au.net.name(){
    iface=$(nmcli device status | awk '$2 == "ethernet" && $3 == "connected" {print $1}')
    nmcli -g GENERAL.CONNECTION device show "$iface"
}

au.net.info(){
    iface=$(nmcli device status | awk '$2 == "ethernet" && $3 == "connected" {print $1}')
    nmcli device show "$iface"
}

au.net.status(){
    nmcli device status
}

au.net.list(){
    nmcli connection show
}

au.net.recn(){
    LAN_NAME="$(au.net.name)"
    sudo nmcli connection down "$LAN_NAME" && nmcli connection up "$LAN_NAME"
}

au.net.reset(){
    WIFI_NAME="$(au.wi.name)"
    sudo nmcli connection modify "$WIFI_NAME" ipv4.route-metric 600
    au.wi.off
}

au.net.staticip(){
    ret=$(__is_empty_args $# "${FUNCNAME[0]} <device>")
    if test "$ret" != "0"; then echo $ret; return; fi

    GATWAY=$(nmcli -g IP4.GATEWAY device show "$1")

    sudo ip route del default dev $1
    sudo ip route add 192.168.0.0/16 via $GATWAY
}

# help
au.net.help(){
    echo "=== Network Commands ==="
    echo "au.net.ip                        - Show IP address of connected Ethernet interface"
    echo "au.net.gateway                   - Show gateway of connected Ethernet interface"
    echo "au.net.name                      - Show name of connected Ethernet interface"
    echo "au.net.info                      - Show detailed information of connected Ethernet interface"
    echo "au.net.status                    - Show status of all network interfaces"
    echo "au.net.list                      - List all network connections"
    echo "au.net.recn                      - Reconnect to the current network"
    echo "au.net.reset                     - Reset the current WiFi connection"
    echo "au.net.staticip <device>         - Set static IP for the specified device"
    echo "                                     Example: au.net.staticip eth0"
    echo ""
    echo "=== Help ==="
    echo "au.net.help                      - Show this command list"
}

# end