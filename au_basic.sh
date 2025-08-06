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
    