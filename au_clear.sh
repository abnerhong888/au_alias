#!/bin/bash

# define

# include 

# start

au.clear.his(){
    # clear history in memory
    history -c
    clear
}

au.clear.his.all(){
     # clear history in memory
    history -c
    # clear ~/.bash_history
    history -w
    clear
}

# help
au.clear.help(){
    echo "=== Clear Commands ==="
    echo "au.clear.his                       - Clear history in memory and screen"
    echo "au.clear.his.all                   - Clear history in memory, ~/.bash_history and screen"
    echo ""
    echo "=== Help ==="
    echo "au.clear.help                      - Show this command list"
}

# end