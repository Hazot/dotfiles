# Kevin's aliases

# General aliases
alias mkdir="mkdir -p"
alias ..="cd .."
alias ...="cd ../.."
alias python='python3'
alias vi='nvim'
alias fd='fd --no-ignore'

# Custom update function call
alias upd='updapack'
alias upda='updapack'

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
alias gs="git status"
alias gits="git status ."

# Alias for "git status -uno ." (ignore untracked files)
alias guno="git status -uno"
alias gitsuno="git status -uno ."

# Alias for git add
alias ga="git add"
alias gitu="git add -u ."
alias gita="git add --all" # same as "git add -A"
alias giat="git add --all" # mistakes were made

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
alias gbra="git branch --all"

# Alias for "git push && git pull"
alias gpush="git push"
alias gpull="git pull"
alias gpul="git pull"
alias gupll="git pull"

# Alias for "git diff"
alias gdiff="git diff"
alias gdif="git diff"

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

# Old aliases
alias udem='cd ~/code/udem/'
alias ghub='cd ~/code/github/'
alias h='cd /home/hazot/'
alias home='cd /home/hazot/'

# alias files='nautilus'
alias files='gio open'

# alias for papers
alias papers='cd ~/Documents/Readings/Papers/'
