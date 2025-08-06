#!/bin/bash

# include 

incs="au_basic.sh "
incs+="au_wifi.sh "
incs+="au_net.sh "
incs+="au_proxy.sh "
incs+="au_clear.sh "

for inc in $incs; do
    if [ -f "$inc" ]; then
        source "$inc"
    fi
done

# start

au.test(){
    echo $incs
    file="au_wifi.sh"
    if [ -f "$file" ]; then
        echo "$file"
    fi

    ret=$(__is_empty_args $# $0)
    if test "$ret" != "0"; then echo $ret; return; fi

    
    echo "autest"
}

au.source(){
    ret=$(__is_file ~/ws/mygit/au_alias/au_alias.sh)
    if test "$ret" != "0"; then echo $ret; return; fi

    source ~/ws/mygit/au_alias/au_alias.sh
}

au.fnmode(){
    echo 2 | sudo tee /sys/module/hid_apple/parameters/fnmode
}

au.maxwin(){
    ret=$(__is_file ~/scripts/maxwin.sh)
    if test "$ret" != "0"; then echo $ret; return; fi

    ~/scripts/maxwin.sh
}

au.ssh(){
    ssh user@192.168.61.28
}






