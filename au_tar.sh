#!/bin/bash

# define

# include 

# start

au.tar(){
    local ret=$(__is_empty_args $# "${FUNCNAME[0]} <folder/file>")
    if test "$ret" != "0"; then echo $ret; return; fi

    tar -czvf $1.tar.gz $1
}

au.tar.to(){
    local ret=$(__is_empty_args $# "${FUNCNAME[0]} <folder/file> <to path>")
    if test "$ret" != "0"; then echo $ret; return; fi

    tar -czvf $2/$1.tar.gz $1
}

au.tar.extract(){
    local ret=$(__is_empty_args $# "${FUNCNAME[0]} <file>")
    if test "$ret" != "0"; then echo $ret; return; fi

    tar -xzvf $1
}

au.tar.extract.to(){
    local ret=$(__is_empty_args $# "${FUNCNAME[0]} <ile> <to path>")
    if test "$ret" != "0"; then echo $ret; return; fi

    tar -xzvf $1 -C $2
}

au.tar.list(){
    local ret=$(__is_empty_args $# "${FUNCNAME[0]} <file>")
    if test "$ret" != "0"; then echo $ret; return; fi

    tar -tf $1
}

au.tar.list.layer(){
    local ret=$(__is_empty_args $# "${FUNCNAME[0]} <file> <layer>")
    if test "$ret" != "0"; then echo $ret; return; fi

    tar -tf $1 | cut -d/ -f1-$2 | sort -u
}

# help
au.tar.help(){
    echo "=== Tar Commands ==="
    echo "au.tar <folder/file>               - Create tar.gz file"
    echo "au.tar.to <folder/file> <to path>  - Create tar.gz file in specified path"
    echo "au.tar.extract <file>              - Extract tar.gz file"
    echo "au.tar.extract.to <file> <to path> - Extract tar.gz file to specified path"
    echo "au.tar.list <file>                 - List files in tar.gz file"
    echo "au.tar.list.layer <file> <layer>   - List files in specified layer of tar.gz file"
    echo ""
    echo "=== Help ==="
    echo "au.tar.help                        - Show this command list"
}

# end