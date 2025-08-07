#!/bin/bash

# include 

# start

au.git.set.user(){
    ret=$(__is_empty_args $# "${FUNCNAME[0]} <name> <email>")
    if test "$ret" != "0"; then echo $ret; return; fi

    git config --global user.name "$1"
    git config --global user.email "$2"
}

au.git.get.user(){
    echo "Name: $(git config --global user.name)"
    echo "Email: $(git config --global user.email)"
}

au.git.set.core_editor.vim(){
    git config --global core.editor "vim"
}

au.git.set.core_editor.vscode(){
    git config --global core.editor "code --wait"
}

au.git.get.core_editor(){
    echo "Core Editor: $(git config --global core.editor)"
}

au.git.set.store_pw(){
    git config --global credential.helper store
}

au.git.set.difftool.vscode(){
    git config --global --unset diff.tool
    git config --global --unset difftool.vscode.cmd
    git config --global --unset difftool.prompt

    git config --global diff.tool vscode
    git config --global difftool.vscode.cmd 'code --wait --reuse-window --diff $LOCAL $REMOTE'
}

au.git.config(){
    git config --global --list
}

au.git.config.edit(){
    git config --global --edit
}


au.git.clone(){
    ret=$(__is_empty_args $# "${FUNCNAME[0]} <url>")
    if test "$ret" != "0"; then echo $ret; return; fi

    git clone $1
}

au.git.add(){
    ret=$(__is_empty_args $# "${FUNCNAME[0]} <file>")
    if test "$ret" != "0"; then echo $ret; return; fi

    git add $1
}

au.git.add.modified(){
    git add $(git diff --name-only)
}

au.git.add.untracked(){
    git add $(git ls-files -o)
}

au.git.commit(){
    ret=$(__is_empty_args $# "${FUNCNAME[0]} <message>")
    if test "$ret" != "0"; then echo $ret; return; fi

    git commit -m "$1"
}

au.git.commit.all(){
    ret=$(__is_empty_args $# "${FUNCNAME[0]} <message>")    
    if test "$ret" != "0"; then echo $ret; return; fi

    git commit -am "$1"
}

au.git.push(){
    git push
}

au.git.pull(){
    git pull
}

au.git.fetch(){
    git fetch
}

au.git.merge(){
    git merge
}

au.git.branch(){
    git branch
}

au.git.branch.all(){
    git branch -a
}

au.git.branch.new(){
    ret=$(__is_empty_args $# "${FUNCNAME[0]} <branch_name>")
    if test "$ret" != "0"; then echo $ret; return; fi

    git branch $1
}

au.git.status(){
    git status
}

au.git.status.short(){
    git status -s
}

au.git.log(){
    git log
}

au.git.log.graph(){
    git log --graph --oneline --all
}

au.git.rebase(){
    ret=$(__is_empty_args $# "${FUNCNAME[0]} <branch_name>")    
    if test "$ret" != "0"; then echo $ret; return; fi

    git rebase $1
}

au.git.files(){
    git ls-files
}

au.git.modified(){
    git ls-files -m
}

au.git.untracked(){
    git ls-files -o
}

au.git.diff(){
    git diff
}

au.git.difftool(){
    git difftool $@
}

au.git.difftool.dir(){
    git difftool --dir-diff
}

au.git.remote(){
    git remote -v
}

au.git.checkout(){
    git checkout $@
}

au.git.reset(){
    git reset
}

au.git.reset.hard(){
    ret=$(__is_empty_args $# "${FUNCNAME[0]} <ID>")
    if test "$ret" != "0"; then echo $ret; return; fi

    git reset --hard $1
}

au.git.reset.soft(){
    ret=$(__is_empty_args $# "${FUNCNAME[0]} <ID>")
    if test "$ret" != "0"; then echo $ret; return; fi

    git reset --soft $1
}

au.git.clean(){
    git clean -fd
}