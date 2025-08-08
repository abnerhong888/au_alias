#!/bin/bash

# define

# include 

# start

au.tree(){
    local ret=$(__is_empty_args $# "${FUNCNAME[0]} <path> <max_depth>")
    if test "$ret" != "0"; then echo $ret; return; fi

    local path="."
    local max_depth=99

    if [ $# -ge 1 ]; then path="$1"; fi
    if [ $# -ge 2 ]; then max_depth="$2"; fi

    find "$path" -type d | sort | awk -v md="$max_depth" -F/ '
    {
        depth = NF - 1
        if (depth <= md) {
            indent = ""
            for (i=1; i<depth; i++) indent = indent "│   "

            # Color: directories blue, files green
            if (system("[ -d \"" $0 "\" ]") == 0) {
                color="\033[34m"  # Blue for directories
            } else {
                color="\033[32m"  # Green for files
            }
            reset="\033[0m"

            print indent "└── " color $NF reset
        }
    }'
}

au.tree.file(){
    local ret=$(__is_empty_args $# "${FUNCNAME[0]} <path> <max_depth>")
    if test "$ret" != "0"; then echo $ret; return; fi

    local path="."
    local max_depth=99

    if [ $# -ge 1 ]; then path="$1"; fi
    if [ $# -ge 2 ]; then max_depth="$2"; fi

    find "$path" -maxdepth "$max_depth" | sort | awk -F/ '
    {
        indent = ""
        for (i=1; i<NF; i++) indent = indent "│   "

        # Color: directories blue, files green
        if (system("[ -d \"" $0 "\" ]") == 0) {
            color="\033[34m"  # Blue for directories
        } else {
            color="\033[32m"  # Green for files
        }
        reset="\033[0m"

        print indent "└── " color $NF reset
    }'
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