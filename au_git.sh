#!/bin/bash

# define

# include 

# start

au.git.set.user(){
    local ret=$(__is_empty_args $# "${FUNCNAME[0]} <name> <email>")
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
    local ret=$(__is_empty_args $# "${FUNCNAME[0]} <url>")
    if test "$ret" != "0"; then echo $ret; return; fi

    git clone $1
}

au.git.add(){
    local ret=$(__is_empty_args $# "${FUNCNAME[0]} <file>")
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
    local ret=$(__is_empty_args $# "${FUNCNAME[0]} <message>")
    if test "$ret" != "0"; then echo $ret; return; fi

    git commit -m "$1"
}

au.git.commit.all(){
    local ret=$(__is_empty_args $# "${FUNCNAME[0]} <message>")    
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
    local ret=$(__is_empty_args $# "${FUNCNAME[0]} <branch_name>")
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

au.git.log.oneline(){
    git log --oneline --all --decorate
}

au.git.log.graph(){
    git log --oneline --graph --decorate --all --branches=main
}

au.git.rebase(){
    local ret=$(__is_empty_args $# "${FUNCNAME[0]} <branch_name>")    
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
    local ret=$(__is_empty_args $# "${FUNCNAME[0]} <ID>")
    if test "$ret" != "0"; then echo $ret; return; fi

    git reset --hard $1
}

au.git.reset.soft(){
    local ret=$(__is_empty_args $# "${FUNCNAME[0]} <ID>")
    if test "$ret" != "0"; then echo $ret; return; fi

    git reset --soft $1
}

au.git.clean(){
    git clean -fd
}

# help
au.git.help(){
    echo "=== Git Configuration Commands ==="
    echo "au.git.set.user <name> <email>     - Set global git user name and email"
    echo "au.git.get.user                    - Get current git user info"
    echo "au.git.set.core_editor.vim         - Set vim as core editor"
    echo "au.git.set.core_editor.vscode      - Set vscode as core editor"
    echo "au.git.get.core_editor             - Get current core editor"
    echo "au.git.set.store_pw                - Enable credential storage"
    echo "au.git.set.difftool.vscode         - Set vscode as diff tool"
    echo "au.git.config                      - Show all git config"
    echo "au.git.config.edit                 - Edit git config"
    echo ""
    echo "=== Repository Management ==="
    echo "au.git.clone <url>                 - Clone repository"
    echo "au.git.remote                      - Show remote repositories"
    echo ""
    echo "=== File Operations ==="
    echo "au.git.add <file>                  - Add file to staging"
    echo "au.git.add.modified                - Add all modified files"
    echo "au.git.add.untracked               - Add all untracked files"
    echo "au.git.files                       - List tracked files"
    echo "au.git.modified                    - List modified files"
    echo "au.git.untracked                   - List untracked files"
    echo ""
    echo "=== Commit Operations ==="
    echo "au.git.commit <message>            - Commit with message"
    echo "au.git.commit.all <message>        - Commit all changes with message"
    echo "au.git.push                        - Push to remote"
    echo "au.git.pull                        - Pull from remote"
    echo "au.git.fetch                       - Fetch from remote"
    echo "au.git.merge                       - Merge branches"
    echo ""
    echo "=== Branch Operations ==="
    echo "au.git.branch                      - List local branches"
    echo "au.git.branch.all                  - List all branches"
    echo "au.git.branch.new <name>           - Create new branch"
    echo "au.git.checkout                    - Checkout branch/commit"
    echo ""
    echo "=== Status & History ==="
    echo "au.git.status                      - Show repository status"
    echo "au.git.status.short                - Show short status"
    echo "au.git.log                         - Show commit log"
    echo "au.git.log.oneline                 - Show oneline log"
    echo "au.git.log.graph                   - Show graph log"
    echo ""
    echo "=== Diff & Compare ==="
    echo "au.git.diff                        - Show differences"
    echo "au.git.difftool                    - Launch diff tool"
    echo "au.git.difftool.dir                - Launch directory diff tool"
    echo ""
    echo "=== Reset & Clean ==="
    echo "au.git.reset                       - Reset staging area"
    echo "au.git.reset.hard <ID>             - Hard reset to commit"
    echo "au.git.reset.soft <ID>             - Soft reset to commit"
    echo "au.git.clean                       - Clean untracked files"
    echo "au.git.rebase <branch>             - Rebase onto branch"
    echo ""
    echo "=== Help ==="
    echo "au.git.help                       - Show this command list"
}

# end