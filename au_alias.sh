#!/bin/bash

# define
AU_ALIAS_DIR="/home/user/ws/mygit/au_alias"

# include 
source "$AU_ALIAS_DIR/au_basic.sh"
source "$AU_ALIAS_DIR/au_wifi.sh"
source "$AU_ALIAS_DIR/au_net.sh"
source "$AU_ALIAS_DIR/au_proxy.sh"
source "$AU_ALIAS_DIR/au_clear.sh"
source "$AU_ALIAS_DIR/au_find.sh"
source "$AU_ALIAS_DIR/au_grep.sh"
source "$AU_ALIAS_DIR/au_tar.sh"
source "$AU_ALIAS_DIR/au_tree.sh"
source "$AU_ALIAS_DIR/au_info.sh"
source "$AU_ALIAS_DIR/au_git.sh"

# start
au.test(){
    echo "autest"
}

au.source.dir(){
    echo $AU_ALIAS_DIR
}

au.source(){
    SH_DIR="$AU_ALIAS_DIR/au_alias.sh"

    ret=$(__is_file $SH_DIR)
    if test "$ret" != "0"; then echo $ret; return; fi

    source $SH_DIR
}

# help
au.help(){
    echo "=== Help ==="
    echo "au.basic.help                  - Show basic commands list"
    echo "au.net.help                    - Show network commands list"
    echo "au.proxy.help                  - Show proxy commands list"
    echo "au.clear.help                  - Show clear commands list"
    echo "au.find.help                   - Show find commands list"
    echo "au.grep.help                   - Show grep commands list"
    echo "au.tar.help                    - Show tar commands list"
    echo "au.tree.help                   - Show tree commands list"
    echo "au.info.help                   - Show info commands list"
    echo "au.git.help                    - Show git commands list"
    echo "au.wi.help                     - Show wifi commands list"
    echo "au.help                        - Show this command list"
}

# end