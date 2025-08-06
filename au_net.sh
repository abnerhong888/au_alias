#!/bin/bash

# include 

if [ -f "au_wifi.sh" ]; then
    source au_wifi.sh
fi

# start
au.net.ip(){
    iface=$(nmcli device status | awk '$2 == "ethernet" && $3 == "connected" {print $1}')
    nmcli -g IP4.ADDRESS device show "$iface" | cut -d/ -f1
}

au.net.status(){
    nmcli device status
}

au.net.list(){
    nmcli connection show
}

au.net.cn.name(){
    nmcli -t -f NAME,DEVICE,TYPE connection show --active | grep ethernet | cut -d ':' -f1
}

au.net.recn(){
    LAN_NAME="$(au.net.cn.name)"
    sudo nmcli connection down "$LAN_NAME" && nmcli connection up "$LAN_NAME"
}

au.net.reset(){
    WIFI_NAME="$(au.wi.cn.name)"
    sudo nmcli connection modify "$WIFI_NAME" ipv4.route-metric 600
    au.wi.off
}

au.net.set.static(){
    ret=$(__is_empty_args $# "${FUNCNAME[0]} <device>")
    if test "$ret" != "0"; then echo $ret; return; fi

    # grep enp2s0 via
    IP=$(ip route | grep $1 | grep -oP 'via \K[0-9.]+')

    sudo ip route del default dev $1
    sudo ip route add 192.168.0.0/16 via $IP
}