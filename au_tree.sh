#!/bin/bash

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