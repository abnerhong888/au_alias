#!/bin/bash

# define

# include 

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

au.fnmode(){
    echo 2 | sudo tee /sys/module/hid_apple/parameters/fnmode
}

b () {
    if [ -f "build.sh" ] ; then
        ./build.sh $@
    elif [ -f "Makefile" ] ; then
        make build
    else
        echo "[au_alias] error: build.sh or Makefile not found."
    fi
}
 
c () {
    if [ -f "clean.sh" ] ; then
        ./clean.sh $@
    elif [ -f "Makefile" ] ; then
        make clean 
    else
        echo "[au_alias] error: clean.sh or Makefile not found."
    fi
}

d () {
    if [ -f "debug.sh" ] ; then
        ./debug.sh $@
    elif [ -f "Makefile" ] ; then
        make debug
    else
        echo "[au_alias] error: debug.sh or Makefile not found."
    fi
}

g () {
    if [ -f "go.sh" ] ; then
        ./go.sh $@
    elif [ -f "Makefile" ] ; then
        make go
    else
        echo "[au_alias] error: go.sh or Makefile not found."
    fi
}

r () {
    if [ -f "run.sh" ] ; then
        ./run.sh $@
    elif [ -f "Makefile" ] ; then
        make run
    else
        echo "[au_alias] error: run.sh or Makefile not found."
    fi
}
# help

au.basic.help(){
    echo "=== Basic Commands ==="
    echo "Navigation aliases:"
    echo "..                                 - cd .."
    echo "...                                - cd ../.."
    echo "....                               - cd ../../.."
    echo ".....                              - cd ../../../.."
    echo "......                             - cd ../../../../.."
    echo ".......                            - cd ../../../../../.."
    echo "........                           - cd ../../../../../../.."
    echo ".........                          - cd ../../../../../../../.."
    echo ""
    echo "File listing:"
    echo "au.ll [path]                       - List files with full paths (enhanced ls -la)"
    echo "au.ls [path]                       - List files with full paths (enhanced ls -l)"
    echo ""
    echo "System monitoring:"
    echo "au.watch <command>                 - Watch command output (refresh every 1s)"
    echo ""
    echo "Fn mode:"
    echo "au.fnmode                          - Set fn mode"
    echo ""
    echo "Build:"
    echo "b                                  - Build"
    echo "c                                  - Clean"
    echo "d                                  - Debug"
    echo "g                                  - Go"
    echo "r                                  - Run"
    echo ""
    echo "=== Help ==="
    echo "au.basic.help                      - Show this command list"
}


# end