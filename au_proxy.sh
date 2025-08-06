#!/bin/bash

# include 

# start

au.pxyl(){
    if [ -z "$1" ]; then
        echo "Usage: au.pxyl <ip/24>"
        return
    fi
    nmap -p 3128,8080,8888,1080 $1
}

au.pxyg(){
    if [ -z "$1" ]; then
        echo "Usage: au.pxyg <ip/24>"
        return
    fi
    nmap -p 3128,8080,8888,1080 $1 | grep -E 'Nmap scan report|open'
}


au.pxy(){
    PROXY_DIR="/home/user/ws/3proxy/bin/"
    CFG_NAME="3proxy.cfg"
    rm $CFG_NAME -f
    touch $CFG_NAME

cat > "$CFG_NAME" << EOL
nscache 65536
timeouts 1 5 30 60 180 1800 15 60

users u:CL:0000user

auth strong
allow u
proxy -p3128
flush
EOL

    sudo true
    clear
    # Run proxy in background
    sudo $PROXY_DIR/3proxy $CFG_NAME &
    PROXY_PID=$!
    
    # Wait for proxy and handle interruption
    trap "kill $PROXY_PID 2>/dev/null;" INT TERM
    wait $PROXY_PID
    
    # Cleanup if proxy exits normally
    rm $CFG_NAME -f
    clear
}