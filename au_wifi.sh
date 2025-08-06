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
    nmcli dev wifi connect $@
}

au.wi.recn(){
    WIFI_NAME="$(au.wi.cn.name)"
    sudo nmcli connection down "$WIFI_NAME" && nmcli connection up "$WIFI_NAME"
}

au.wi.cn.name(){
    nmcli -t -f active,ssid dev wifi | grep ^yes | cut -d ':' -f2
}

au.wi.lowp(){
    WIFI_NAME="$(au.wi.cn.name)"
    sudo nmcli connection modify "$WIFI_NAME" ipv4.route-metric 99999
    au.wi.recn
}

au.wi.lowp.reset(){
    WIFI_NAME="$(au.wi.cn.name)"
    sudo nmcli connection modify "$WIFI_NAME" ipv4.route-metric 600
    au.wi.recn
}