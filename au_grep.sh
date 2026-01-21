#!/bin/bash

# define

# include 

# start

au.grep(){
    local ret=$(__is_empty_args $# "${FUNCNAME[0]} <"RegularExpression"> <FileName/Path>")
    if test "$ret" != "0"; then echo $ret; return; fi

    local path="."
    
    if [ $# -ge 2 ]; then path="$2"; fi
    
    grep -ZnrE $1 $path
}

au.grep.ext(){
    local ret=$(__is_empty_args $# "${FUNCNAME[0]} <.ext> <"RegularExpression"> <FileName/Path>")
    if test "$ret" != "0"; then echo $ret; return; fi

    local path="."
    
    if [ $# -ge 3 ]; then path="$3"; fi
    
    grep -ZnrE --include=\*$1 $2 $path
}

# help
au.grep.help(){
    echo "=== Grep Commands ==="
    echo "au.grep <"ReguExpre"> <FileName/Path>                  - Search for pattern in all files recursively  "
    echo "                                                       Uses: grep -ZnrE \"Regular Expression\" <FileName/Path>"
    echo ""
    echo "au.grep.ext <extension> <RequExpre> <FileName/Path>  - Search for pattern in files with specific extension"
    echo "                                                       Uses: grep -ZnrE --include=*<ext> \"Regular Expression\" <FileName/Path>"
    echo ""
    echo "=== Help ==="
    echo "au.grep.help                                         - Show this command list"
}

# end
