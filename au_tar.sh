#!/bin/bash

# include 

# start

au.tar(){
    ret=$(__is_empty_args $# "${FUNCNAME[0]} <folder/file>")
    if test "$ret" != "0"; then echo $ret; return; fi

    tar -czvf $1.tar.gz $1
}

au.tar.to(){
    ret=$(__is_empty_args $# "${FUNCNAME[0]} <folder/file> <to path>")
    if test "$ret" != "0"; then echo $ret; return; fi

    tar -czvf $2/$1.tar.gz $1
}

au.tar.extract(){
    ret=$(__is_empty_args $# "${FUNCNAME[0]} <file>")
    if test "$ret" != "0"; then echo $ret; return; fi

    tar -xzvf $1
}

au.tar.extract.to(){
    ret=$(__is_empty_args $# "${FUNCNAME[0]} <ile> <to path>")
    if test "$ret" != "0"; then echo $ret; return; fi

    tar -xzvf $1 -C $2
}

au.tar.list(){
    ret=$(__is_empty_args $# "${FUNCNAME[0]} <file>")
    if test "$ret" != "0"; then echo $ret; return; fi

    tar -tf $1
}

au.tar.list.layer(){
    ret=$(__is_empty_args $# "${FUNCNAME[0]} <file> <layer>")
    if test "$ret" != "0"; then echo $ret; return; fi

    tar -tf $1 | cut -d/ -f1-$2 | sort -u
}