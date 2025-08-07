#!/bin/bash

# include 

# start

au.info.cpu(){
    cat /proc/cpuinfo
}

au.info.cpu.temp(){
    cat /sys/class/thermal/thermal_zone0/temp
}

au.info.memory(){
    free -h
}

au.info.fsize(){
    ret=$(__is_empty_args $# "${FUNCNAME[0]} <folder>")
    if test "$ret" != "0"; then echo $ret; return; fi
    
    du -sh $1
}

au.info.linux(){
    echo -------------------------- uname -r
    uname -r
    echo -------------------------- uname -a
    uname -a
    echo -------------------------- lsb_release -a
    lsb_release -a
    echo -------------------------- cat /etc/os-release
    cat /etc/os-release
    echo -------------------------- cat /etc/issue
    cat /etc/issue
}