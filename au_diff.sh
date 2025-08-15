#!/bin/bash

# define

# include 

# start
au.diff.file(){
    local ret=$(__is_empty_args $# "${FUNCNAME[0]} <file1> <file2>")
    if test "$ret" != "0"; then echo $ret; return; fi

    diff -u --color=always "$1" "$2"
}

au.diff.folder(){
    local ret=$(__is_empty_args $# "${FUNCNAME[0]} <folder1> <folder2>")
    if test "$ret" != "0"; then echo $ret; return; fi

    diff -ru --color=always "$1" "$2"
}

# help
au.diff.help(){
    echo "=== Diff Commands ==="
    echo "au.diff.file <file1> <file2>      - Diff two files"
    echo "au.diff.folder <folder1> <folder2> - Diff two folders"
    echo ""
    echo "=== Help ==="
    echo "au.diff.help                       - Show this command list"
}

# end