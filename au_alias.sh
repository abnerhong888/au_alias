#!/bin/bash

# define
AU_ALIAS_DIR="/home/user/ws/mygit/au_alias"
AU_CURR_FILE="au_alias.sh"
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
source "$AU_ALIAS_DIR/au_diff.sh"

# start
au.test(){
    echo "autest"
}

au.source.dir(){
    if [ $AU_CURR_FILE == "au_alias.sh" ]; then
        echo $AU_ALIAS_DIR
    else
        echo "[au_alias] error: source dir not found"
    fi
}

au.source(){
    local SH_DIR="$AU_ALIAS_DIR/$AU_CURR_FILE"

    local ret=$(__is_file $SH_DIR)
    if test "$ret" != "0"; then echo $ret; return; fi

    if [ -f "$SH_DIR" ]; then
        source $SH_DIR
    else
        echo "[au_alias] error: $SH_DIR not found"
    fi
}

au.source.bashrc(){
    source ~/.bashrc
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
    echo "au.diff.help                   - Show diff commands list"
    echo "au.wi.help                     - Show wifi commands list"
    echo "au.help                        - Show this command list"
    echo "au.help.all                    - Show help ofall commands list"
}

au.help.all(){
    au.help
    au.basic.help
    au.net.help
    au.proxy.help
    au.clear.help
    au.find.help
    au.grep.help
    au.tar.help
    au.tree.help
    au.info.help
    au.git.help
    au.diff.help
    au.wi.help
}

# end