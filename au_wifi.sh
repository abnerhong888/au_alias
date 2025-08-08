#!/bin/bash

# define

# include 

# start

au.wi.on(){
    nmcli radio wifi on
}

au.wi.off(){
    nmcli radio wifi off
}

au.wi.list(){
    nmcli dev wifi list
}

au.wi.cn(){
    ret=$(__is_empty_args $# "${FUNCNAME[0]} <name>")
    if test "$ret" != "0"; then echo $ret; return; fi

    nmcli dev wifi connect $@
}

au.wi.ip(){
    iface=$(nmcli device status | awk '$2 == "wifi" && $3 == "connected" {print $1}')
    nmcli -g IP4.ADDRESS device show "$iface" | cut -d/ -f1
}

au.wi.gateway(){
    iface=$(nmcli device status | awk '$2 == "wifi" && $3 == "connected" {print $1}')
    nmcli -g IP4.GATEWAY device show "$iface"
}

au.wi.name(){
    iface=$(nmcli device status | awk '$2 == "wifi" && $3 == "connected" {print $1}')
    nmcli -g GENERAL.CONNECTION device show "$iface"
}

au.wi.info(){
    iface=$(nmcli device status | awk '$2 == "wifi" && $3 == "connected" {print $1}')
    nmcli device show "$iface"
}

au.wi.recn(){
    WIFI_NAME="$(au.wi.name)"
    sudo nmcli connection down "$WIFI_NAME" && nmcli connection up "$WIFI_NAME"
}

au.wi.lowp(){
    WIFI_NAME="$(au.wi.name)"
    sudo nmcli connection modify "$WIFI_NAME" ipv4.route-metric 99999
    au.wi.recn
}

au.wi.lowp.reset(){
    WIFI_NAME="$(au.wi.name)"
    sudo nmcli connection modify "$WIFI_NAME" ipv4.route-metric 600
    au.wi.recn
}

# help
au.wi.help(){
    echo "=== WiFi Commands ==="
    echo "au.wi.on                       - Turn on WiFi"
    echo "au.wi.off                      - Turn off WiFi"
    echo "au.wi.list                     - List available WiFi networks"
    echo "au.wi.cn <name>                - Connect to a WiFi network"
    echo "au.wi.ip                       - Show IP address of connected WiFi interface"
    echo "au.wi.gateway                  - Show gateway of connected WiFi interface"
    echo "au.wi.name                     - Show name of connected WiFi interface"
    echo "au.wi.info                     - Show detailed information of connected WiFi interface"
    echo "au.wi.recn                     - Reconnect to the current WiFi network"
    echo "au.wi.lowp                     - Set WiFi connection to lowest priority"
    echo "au.wi.lowp.reset               - Reset WiFi connection priority to default"
    echo ""
    echo "=== Help ==="
    echo "au.wi.help                     - Show this command list"
}

# end