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
    local red="\033[31m"
    local reset="\033[0m"

    # Function to process an ls output line and replace filename with full path
    _au_ll_process_line() {
        local dir="$1"
        local line="$2"
        # Extract filename (last field after space split)
        local fname="${line##* }"
        if [[ "$fname" != "." && "$fname" != ".." ]]; then
            local abs_path
            abs_path="$(realpath -- "$dir/$fname" 2>/dev/null)"
            # Replace only at the end
            echo "${line%"$fname"}$abs_path"
        else
            echo "$line"
        fi
    }

    if [ $# -eq 0 ]; then
        # Current directory
        while IFS= read -r line; do
            _au_ll_process_line "." "$line"
        done < <(ls -la --color=always | tail -n +2)
    else
        for arg in "$@"; do
            if [ -d "$arg" ]; then
                printf "Directory: %s\n" "$(realpath "$arg")"
                while IFS= read -r line; do
                    _au_ll_process_line "$arg" "$line"
                done < <(ls -la --color=always -- "$arg" | tail -n +2)
            elif [ -f "$arg" ]; then
                while IFS= read -r line; do
                    _au_ll_process_line "$(dirname "$arg")" "$line"
                done < <(ls -la --color=always -- "$arg")
            else
                printf "%b[au_alias] error:%b %s not found\n" "$red" "$reset" "$arg"
            fi
        done
    fi
}

au.ls(){
    local red="\033[31m"
    local reset="\033[0m"

    # Function to process an ls output line and replace filename with full path
    _au_ll_process_line() {
        local dir="$1"
        local line="$2"
        # Extract filename (last field after space split)
        local fname="${line##* }"
        
        local abs_path
        abs_path="$(realpath -- "$dir/$fname" 2>/dev/null)"
        # Replace only at the end
        echo "$abs_path"
    }

    if [ $# -eq 0 ]; then
        # Current directory
        while IFS= read -r line; do
            _au_ll_process_line "." "$line"
        done < <(ls -la --color=always | tail -n +2)
    else
        for arg in "$@"; do
            if [ -d "$arg" ]; then
                printf "Directory: %s\n" "$(realpath "$arg")"
                while IFS= read -r line; do
                    _au_ll_process_line "$arg" "$line"
                done < <(ls -la --color=always -- "$arg" | tail -n +2)
            elif [ -f "$arg" ]; then
                while IFS= read -r line; do
                    _au_ll_process_line "$(dirname "$arg")" "$line"
                done < <(ls -la --color=always -- "$arg")
            else
                printf "%b[au_alias] error:%b %s not found\n" "$red" "$reset" "$arg"
            fi
        done
    fi
}

au.watch(){
    local ret=$(__is_empty_args $# "${FUNCNAME[0]} <\"command\">")
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