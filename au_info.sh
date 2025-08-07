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

# help
au.info.help(){
    echo "=== System Info Commands ==="
    echo "au.info.cpu                        - Show CPU information (/proc/cpuinfo)"
    echo "au.info.cpu.temp                   - Show CPU temperature"
    echo "au.info.memory                     - Show memory usage (free -h)"
    echo "au.info.fsize <folder>             - Show folder size (du -sh)"
    echo "au.info.linux                     - Show comprehensive Linux system info"
    echo "                                     Includes: uname, lsb_release, os-release, issue"
    echo ""
    echo "=== Help ==="
    echo "au.info.help                       - Show this command list"
}