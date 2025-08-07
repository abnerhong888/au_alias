#!/bin/bash

# include 

incs="au_basic.sh "
incs+="au_wifi.sh "
incs+="au_net.sh "
incs+="au_proxy.sh "
incs+="au_clear.sh "
incs+="au_find.sh "
incs+="au_grep.sh "
incs+="au_tar.sh "
incs+="au_tree.sh "
incs+="au_info.sh "
incs+="au_git.sh "

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
    SH_DIR="/home/user/ws/mygit/au_alias/au_alias.sh"

    ret=$(__is_file $SH_DIR)
    if test "$ret" != "0"; then echo $ret; return; fi

    source $SH_DIR
}

au.fnmode(){
    echo 2 | sudo tee /sys/module/hid_apple/parameters/fnmode
}

au.maxwin(){
    SH_DIR="/home/user/scripts/maxwin.sh"

    ret=$(__is_file $SH_DIR)
    if test "$ret" != "0"; then echo $ret; return; fi

    $SH_DIR
}

au.ssh(){
    ssh user@192.168.61.28
}

