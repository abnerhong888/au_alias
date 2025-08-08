#!/bin/bash

# define

# include 

# start

au.pxy.list(){
    ret=$(__is_empty_args $# "${FUNCNAME[0]} <ip/24>")
    if test "$ret" != "0"; then echo $ret; return; fi
    
    nmap -p 3128,8080,8888,1080 $1
}

au.pxy.grep(){
    ret=$(__is_empty_args $# "${FUNCNAME[0]} <ip/24>")
    if test "$ret" != "0"; then echo $ret; return; fi

    nmap -p 3128,8080,8888,1080 $1 | grep -E 'Nmap scan report|open'
}


au.3pxy(){
    PROXY_DIR="/home/user/ws/3proxy/bin"
    PROXY_EXE="$PROXY_DIR/3proxy"
    CFG_NAME="3proxy.cfg"

    ret=$(__is_file $PROXY_EXE)
    if test "$ret" != "0"; then echo $ret; return; fi

    ret=$(__is_empty_args $# "${FUNCNAME[0]} <user> <password>")
    if test "$ret" != "0"; then echo $ret; return; fi

    rm $CFG_NAME -f
    touch $CFG_NAME

cat > "$CFG_NAME" << EOL
nscache 65536
timeouts 1 5 30 60 180 1800 15 60

users $1:CL:$2

auth strong
allow $1
proxy -p3128
flush
EOL

    sudo true
    clear
    # Run proxy in background
    sudo $PROXY_EXE $CFG_NAME &
    PROXY_PID=$!
    
    # Wait for proxy and handle interruption
    set +m # Disables job control notifications
    trap "kill $PROXY_PID 2>/dev/null;" INT TERM
    wait $PROXY_PID

    # Cleanup if proxy exits normally
    rm $CFG_NAME -f
    clear
}

# help
au.pxy.help(){
    echo "=== Proxy Commands ==="
    echo "au.pxy.list <ip/24>                 - List open ports on a subnet"
    echo "au.pxy.grep <ip/24>                 - List open ports on a subnet and grep for open ports"
    echo "au.3pxy <user> <password>           - Start 3proxy server with specified user and password"
    echo "                                     Example: au.3pxy user password"
    echo ""
    echo "=== Help ==="
    echo "au.pxy.help                        - Show this command list"
}

# end