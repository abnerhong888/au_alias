#!/bin/bash

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