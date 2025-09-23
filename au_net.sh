#!/bin/bash

# define

# include 

if [ -f "au_wifi.sh" ]; then
    source au_wifi.sh
fi

# start

au.net.ip(){
    local iface=$(nmcli device status | awk '$2 == "ethernet" && $3 == "connected" {print $1}')
    nmcli -g IP4.ADDRESS device show "$iface" | cut -d/ -f1
}

au.net.gateway(){
    local iface=$(nmcli device status | awk '$2 == "ethernet" && $3 == "connected" {print $1}')
    nmcli -g IP4.GATEWAY device show "$iface"
}

au.net.name(){
    local iface=$(nmcli device status | awk '$2 == "ethernet" && $3 == "connected" {print $1}')
    nmcli -g GENERAL.CONNECTION device show "$iface"
}

au.net.info(){
    local iface=$(nmcli device status | awk '$2 == "ethernet" && $3 == "connected" {print $1}')
    nmcli device show "$iface"
}

au.net.status(){
    nmcli device status
}

au.net.list(){
    nmcli connection show
}

au.net.recn(){
    local LAN_NAME="$(au.net.name)"
    sudo nmcli connection down "$LAN_NAME" && nmcli connection up "$LAN_NAME"
}

au.net.reset(){
    local WIFI_NAME="$(au.wi.name)"
    sudo nmcli connection modify "$WIFI_NAME" ipv4.route-metric 600
    au.wi.off
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
    echo ""
    echo "=== Help ==="
    echo "au.net.help                      - Show this command list"
}

# end