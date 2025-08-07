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

# help
au.grep.help(){
    echo "=== Grep Commands ==="
    echo "au.grep <pattern>                  - Search for pattern in all files recursively"
    echo "                                     Uses: grep -Znr . -e <pattern>"
    echo ""
    echo "au.grep.ext <extension> <pattern>  - Search for pattern in files with specific extension"
    echo "                                     Uses: grep -Znr --include=*<ext> . -e <pattern>"
    echo "                                     Example: au.grep.ext .py 'def main'"
    echo ""
    echo "=== Help ==="
    echo "au.grep.help                       - Show this command list"
}