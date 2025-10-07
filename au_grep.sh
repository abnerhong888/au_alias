#!/bin/bash

# define

# include 

# start

au.grep(){
    local ret=$(__is_empty_args $# "${FUNCNAME[0]} <name>")
    if test "$ret" != "0"; then echo $ret; return; fi

    grep -Znr . -e "$1"
}

au.grep.ext(){
    local ret=$(__is_empty_args $# "${FUNCNAME[0]} <.ext> <name>")
    if test "$ret" != "0"; then echo $ret; return; fi

    grep -Znr --include=\*$1 . -e "$2"
}

au.grep.func(){
    local ret=$(__is_empty_args $# "${FUNCNAME[0]} <function name> <file>")
    if test "$ret" != "0"; then echo $ret; return; fi

    grep -Pzo "$1\s*\(.*\)\s*{([^}]*)}" $2
    echo ""
}

au.grep.func.au_alias_one(){
    local ret=$(__is_empty_args $# "${FUNCNAME[0]} <function name>")
    if test "$ret" != "0"; then echo $ret; return; fi

    grep -Pzo "$1\s*\(.*\)\s*{([^}]*)}" ~/.au_alias_one
    echo ""
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
    echo "au.grep.func <function name> <file>- Search for function content in file"
    echo ""
    echo "au.grep.func.au_alias_one <function name> - Search for function content in .au_alias_one"
    echo ""
    echo "=== Help ==="
    echo "au.grep.help                       - Show this command list"
}

# end
