#!/bin/bash

# define

# include 

# start

au.tree(){
    ls -R | grep ":$" | sed -e 's/:$//' -e 's/[^-][^\/]*\//──/g' -e 's/─/├/' -e '$s/├/└/'
}

au.tree.file(){
    find "${1:-.}" \
    -not -regex ".*\/((.idea|.git|.venv|node_modules|venv)\/.*|.DS_Store)" \
  | sort | sed \
    -e "s/[^-][^\/]*\// ├ /g" \
    -e "s/├ \//├ /g" \
    -e "s/├  ├/│  ├/g" \
    -e "s/├  ├/│  ├/g" \
    -e "s/├  │/│  │/g" \
    -e '$s/├/└/'
}

# help
au.tree.help(){
    echo "=== Tree Commands ==="
    echo "au.tree                        - Show directory tree"
    echo "au.tree.file <path>             - Show directory tree with file paths"
    echo ""
    echo "=== Help ==="
    echo "au.tree.help                   - Show this command list"
}

# end