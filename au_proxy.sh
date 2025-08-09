#!/bin/bash

# define

# include 

# start

au.pxy.list(){
    local ret=$(__is_empty_args $# "${FUNCNAME[0]} <ip/24>")
    if test "$ret" != "0"; then echo $ret; return; fi
    
    nmap -p 3128,8080,8888,1080 $1
}

au.pxy.grep(){
    local ret=$(__is_empty_args $# "${FUNCNAME[0]} <ip/24>")
    if test "$ret" != "0"; then echo $ret; return; fi

    nmap -p 3128,8080,8888,1080 $1 | grep -E 'Nmap scan report|open'
}


au.3pxy(){
    local PROXY_DIR="/home/user/ws/3proxy/bin"
    local PROXY_EXE="$PROXY_DIR/3proxy"
    local CFG_NAME="3proxy.cfg"

    local ret=$(__is_file $PROXY_EXE)
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
    local PROXY_PID=$!
    
    # Wait for proxy and handle interruption
    set +m # Disables job control notifications
    trap "kill $PROXY_PID 2>/dev/null;" INT TERM
    wait $PROXY_PID

    # Cleanup if proxy exits normally
    rm $CFG_NAME -f
    clear
}

au.pxy.chrome(){
    local ret=$(__is_empty_args $# "${FUNCNAME[0]} <user:password@ip>")
    if test "$ret" != "0"; then echo $ret; return; fi

    google-chrome --proxy-server="http://$1:3128"
    history -c
    clear
}

au.pxy.vscode(){
    local ret=$(__is_empty_args $# "${FUNCNAME[0]} <user:password@ip>")
    if test "$ret" != "0"; then echo $ret; return; fi

    local TEMP_DIR="/tmp/my_temp_code"
    local SETTING_FILE="$TEMP_DIR/User/settings.json"

    if [ ! -d "$TEMP_DIR" ]; then
        mkdir -p $TEMP_DIR
        cp ~/.config/Code/* $TEMP_DIR -rf
    fi

    clear
    __edit_settings $1 1 $SETTING_FILE

    code $2 --wait --user-data-dir=$TEMP_DIR
    
    __edit_settings $1 0 $SETTING_FILE
    history -c
    clear
}

au.pxy.windsurf(){
    local ret=$(__is_empty_args $# "${FUNCNAME[0]} <user:password@ip>")
    if test "$ret" != "0"; then echo $ret; return; fi

    local TEMP_DIR="/tmp/my_temp_windsurf"
    local SETTING_FILE="$TEMP_DIR/User/settings.json"

    if [ ! -d "$TEMP_DIR" ]; then
        mkdir -p $TEMP_DIR
        cp ~/.config/Windsurf/* $TEMP_DIR -rf
    fi

    clear
    __edit_settings $1 1 $SETTING_FILE

    windsurf $2 --wait --user-data-dir=$TEMP_DIR
    
    __edit_settings $1 0 $SETTING_FILE
    history -c
    clear
}

__edit_settings(){
    local IP_PASSWORD=$1
    local ENABLE=$2
    local SETTING_FILE=$3
    # 0,/{/{...} - replace first { with {...}
    if ! grep -q '"http.proxyStrictSSL":' $SETTING_FILE; then
        sed -i '0,/{/{s/{/{\n    "http.proxyStrictSSL": false,/}' $SETTING_FILE
    fi
    
    if ! grep -q '"http.proxy":' $SETTING_FILE; then
        sed -i '0,/{/{s/{/{\n    "http.proxy": "",/}' $SETTING_FILE
    fi

    local VAL="http://$IP_PASSWORD:3128"  # Properly escaped quotes for JSON
    local SEARCH_VAR='"http.proxy": "",'  # What to search for
    local REPLACE_VAR="\"http.proxy\": \"$VAL\","  # Replacement with variable

    if [ "$ENABLE" = "1" ]; then
        # Enable proxy by replacing empty with value
        sed -i "s|$SEARCH_VAR|$REPLACE_VAR|g" "$SETTING_FILE"
    elif [ "$ENABLE" = "0" ]; then
        # Disable proxy by replacing value with empty
        sed -i "s|$REPLACE_VAR|$SEARCH_VAR|g" "$SETTING_FILE"
    fi
}


# help
au.pxy.help(){
    echo "=== Proxy Commands ==="
    echo "au.pxy.list <ip/24>                 - List open ports on a subnet"
    echo "au.pxy.grep <ip/24>                 - List open ports on a subnet and grep for open ports"
    echo "au.3pxy <user> <password>           - Start 3proxy server with specified user and password"
    echo "                                     Example: au.3pxy user password"
    echo ""
    echo "=== Chrome ==="
    echo "au.pxy.chrome <user:password@ip>   - Open chrome with proxy"
    echo "                                     Example: au.pxy.chrome user:password@ip"
    echo ""
    echo "=== VSCode ==="
    echo "au.pxy.vscode <user:password@ip>   - Open vscode with proxy"
    echo "                                     Example: au.pxy.vscode user:password@ip"
    echo ""
    echo "=== Help ==="
    echo "au.pxy.help                        - Show this command list"
}

# end