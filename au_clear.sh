#!/bin/bash

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