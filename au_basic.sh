#!/bin/bash

# include 

#### check empty args example
# ret=$(__is_empty_args $# "${FUNCNAME[0]} <command>")
#     if test "$ret" != "0"; then echo $ret; return; fi

# start

__print_usage(){
    echo "[au_alias] Usage: $@"
}

__is_empty_args(){
    if [ $1 -eq 0 ]; then
        __print_usage $2
        return
    fi
    echo 0
}

__is_file(){
    if [ ! -f $1 ]; then
        echo "[au_alias] error: File $1 not found"
        return
    fi
    echo 0
}

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'
alias .......='cd ../../../../../..'
alias ........='cd ../../../../../../..'
alias .........='cd ../../../../../../../..'

au.ll(){
    # List files with full path information
    if [ $# -eq 0 ]; then
        # No arguments - list current directory with full paths
        ls -la | sed "1d" | while read -r line; do
            filename=$(echo "$line" | awk '{print $NF}')
            if [ "$filename" != "." ] && [ "$filename" != ".." ]; then
                echo "$line" | sed "s|$filename|$(pwd)/$filename|"
            else
                echo "$line"
            fi
        done
    else
        # With arguments - list specified paths
        for arg in "$@"; do
            if [ -d "$arg" ]; then
                echo "Directory: $(realpath "$arg")"
                ls -la "$arg" | sed "1d" | while read -r line; do
                    filename=$(echo "$line" | awk '{print $NF}')
                    if [ "$filename" != "." ] && [ "$filename" != ".." ]; then
                        echo "$line" | sed "s|$filename|$(realpath "$arg")/$filename|"
                    else
                        echo "$line"
                    fi
                done
            elif [ -f "$arg" ]; then
                ls -la "$arg" | sed "s|$(basename "$arg")|$(realpath "$arg")|"
            else
                echo "[au_alias] error: $arg not found"
            fi
        done
    fi
}

au.ls(){
    # List files with full path information
    if [ $# -eq 0 ]; then
        # No arguments - list current directory with full paths
        ls -l | sed "1d" | while read -r line; do
            filename=$(echo "$line" | awk '{print $NF}')
            echo "$(pwd)/$filename"
        done
    else
        # With arguments - list specified paths
        for arg in "$@"; do
            if [ -d "$arg" ]; then
                echo "Directory: $(realpath "$arg")"
                ls -l "$arg" | sed "1d" | while read -r line; do
                    filename=$(echo "$line" | awk '{print $NF}')
                    echo "$(pwd)/$filename"
                done
            elif [ -f "$arg" ]; then
                filename=$(ls -l "$arg" | awk '{print $NF}')
                echo "$(pwd)/$filename"
            else
                echo "[au_alias] error: $arg not found"
            fi
        done
    fi
}

au.watch(){
    ret=$(__is_empty_args $# "${FUNCNAME[0]} <\"command\">")
    if test "$ret" != "0"; then echo $ret; return; fi

    watch -n 1 "$1"
}
