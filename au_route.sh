#!/bin/bash

# define

# include 

# start

au.route(){
    ip route
}

au.route.del(){
    local ret=$(__is_empty_args $# "${FUNCNAME[0]} <ip/24> <device>")
    if test "$ret" != "0"; then echo $ret; return; fi

    sudo ip route del $1 dev $2
}

au.route.add(){
    local ret=$(__is_empty_args $# "${FUNCNAME[0]} <ip/24> <device>")
    if test "$ret" != "0"; then echo $ret; return; fi

    local GATEWAY=$(nmcli -g IP4.GATEWAY device show "$2")

    sudo ip route add $1 via $GATEWAY dev $2
}

au.route.add.full(){
    local ret=$(__is_empty_args $# "${FUNCNAME[0]} <ip/24> <gateway> <device>")
    if test "$ret" != "0"; then echo $ret; return; fi

    sudo ip route add $1 via $2 dev $3
}

au.route.forward(){
    local ret=$(__is_empty_args $# "${FUNCNAME[0]} <device>")
    if test "$ret" != "0"; then echo $ret; return; fi

    sudo sysctl -w net.ipv4.ip_forward=1
    sudo iptables -P FORWARD ACCEPT
    sudo iptables -t nat -A POSTROUTING -o $1 -j MASQUERADE
}

au.route.forward.off(){
    local ret=$(__is_empty_args $# "${FUNCNAME[0]} <device>")
    if test "$ret" != "0"; then echo $ret; return; fi

    sudo sysctl -w net.ipv4.ip_forward=0
    sudo iptables -P FORWARD DROP
    sudo iptables -t nat -D POSTROUTING -o $1 -j MASQUERADE
}

# help
au.route.help(){
    echo "=== Route ==="
    echo "au.route                         - Show route table"
    echo "au.route.del <ip/24> <device>     - Delete default route for the specified device"
    echo "au.route.add <ip/24> <device>     - Add default route for the specified device"
    echo "au.route.add.full <ip/24> <gateway> <device>     - Add full route for the specified device"
    echo "au.route.forward <device>         - Enable IP forwarding and NAT for the specified device"
    echo "au.route.forward.off <device>     - Disable IP forwarding and NAT for the specified device"
    echo ""
    echo "=== Help ==="
    echo "au.route.help                    - Show this command list"
}

# end