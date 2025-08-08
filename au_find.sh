#!/bin/bash

# define

# include 

# start

au.find(){
    local ret=$(__is_empty_args $# "${FUNCNAME[0]} \"<pattern>\"")
    if test "$ret" != "0"; then echo $ret; return; fi

    find . -name "$1"
}

au.find.dir(){
    if [ $# -eq 0 ]; then
        echo "---Directory:"
        find . -type d | while read -r line; do
            echo "$line" | sed "s|$(basename ".")|$(realpath ".")|"
        done
    else
        # With arguments - list specified paths
        for arg in "$@"; do
            if [ -d "$arg" ]; then
                echo "---Directory:"
                find "$arg" -type d | while read -r line; do
                    echo "$line" | sed "s|$(basename "$arg")|$(realpath "$arg")|"
                done
            else
                echo "[au_alias] error: $arg not found"
            fi
        done
    fi
}

au.find.file(){
    if [ $# -eq 0 ]; then
        echo "---Directory:"
        echo "$(realpath ".")"
        find . -type f | while read -r line; do
            echo "$line" | sed "s|$(basename ".")|$(realpath ".")|"
        done
    else
        # With arguments - list specified paths
        for arg in "$@"; do
            if [ -d "$arg" ]; then
                echo "---Directory:"
                echo "$(realpath "$arg")"
                find "$arg" -type f | while read -r line; do
                    echo "$line" | sed "s|$(basename "$arg")|$(realpath "$arg")|"
                done
            else
                echo "[au_alias] error: $arg not found"
            fi
        done
    fi
}

# help
au.find.help(){
    echo "=== Find Commands ==="
    echo "au.find.dir [path]                 - Find directories with full paths"
    echo "                                     No args: find all dirs in current directory"
    echo "                                     With args: find dirs in specified paths"
    echo ""
    echo "au.find.file [path]                - Find files with full paths"
    echo "                                     No args: find all files in current directory"
    echo "                                     With args: find files in specified paths"
    echo ""
    echo "=== Help ==="
    echo "au.find.help                       - Show this command list"
}

# end