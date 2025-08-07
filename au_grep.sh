#!/bin/bash

# include 

# start

au.grep(){
    ret=$(__is_empty_args $# "${FUNCNAME[0]} <name>")
    if test "$ret" != "0"; then echo $ret; return; fi

    grep -Znr . -e "$1"
}

au.grep.ext(){
    ret=$(__is_empty_args $# "${FUNCNAME[0]} <.ext> <name>")
    if test "$ret" != "0"; then echo $ret; return; fi

    grep -Znr --include=\*$1 . -e "$2"
}