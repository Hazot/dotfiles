# Kevin's aliases

# General aliases
alias mkdir="mkdir -p"
alias ..="cd .."
alias python='python3'
alias vim='nvim'

# Alias for listing directories 
alias ls='ls --color=auto'
alias ll="ls -lAh --group-directories-first --color=auto"
# alias ll="ls -alF --color=auto"
alias la="ls -A --color=auto"
alias l="ls -ClF --group-directories-first --color=auto"
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'

# Alias for ls that hides auxiliary LaTeX files
alias lst="ls -lh -I '*.aux' -I '*.bbl' -I '*.blg' -I '*.fdb_latexmk' -I '*.fls' -I '*.log' -I '*.out' -I '*.thm' -I '*.synctex.gz' --group-directories-first"


# Alias for "git status ."
alias gits="git status ."

# Alias for "git status -uno ." (ignore untracked files)
alias gitsuno="git status -uno ."

# Alias for "git add -u ."
alias gitu="git add -u ."

# Alias for "git add --all"
alias gita="git add --all"

# Alias for "git commit -m"
alias gitc="git commit -m"

# Alias for "git fetch"
alias gitf="git fetch"
alias gf="git fetch"

# Alias for "git fetch --options"
alias gfp="git fetch --prune"
alias gfa="git fetch --all"
alias gaf="git fetch --all" # because I always to that mistake by typing too fast

# Alias for "git checkout"
alias gitchk="git checkout"
alias gchk="git checkout"

# Alias for "git checkout"
alias gitbr="git branch"
alias gbr="git branch"

# Alias for "git push && git pull"
alias gpush="git push"
alias gpull="git pull"
alias gpul="git pull"

# Alias for "git log --all --decorate --oneline --graph"
# See: https://i.stack.imgur.com/ElVkf.jpg
alias glog="git log --all --decorate --oneline --graph"

# Alias for "git ls-tree -r master --name-only"
alias gitls="git ls-tree -r master --name-only"

# Other aliases
alias ju="jupyter notebook --no-browser"
alias julab="jupyter-lab --no-browser"
alias ca='conda activate'
alias cdc='conda deactivate'
alias ctf='conda activate tf'
alias ctor='conda activate torch'
alias wk='workon'
alias dc='deactivate'

alias udem='cd ~/code/udem/'
alias ghub='cd ~/code/github/'
alias winghub='cd /mnt/c/Users/kevin/github/'
alias h='cd /mnt/c/Users/kevin/'
alias home='cd /mnt/c/Users/kevin/'
alias winhome='cd /mnt/c/Users/kevin/'
alias wksp='cd /mnt/e/onedrive.udem/OneDrive\ -\ Universite\ de\ Montreal/Root/School/UdeM/workspace/'
alias workspace='cd /mnt/e/onedrive.udem/OneDrive\ -\ Universite\ de\ Montreal/Root/School/UdeM/workspace/'

# Windows files
alias files='/mnt/c/Windows/explorer.exe'
