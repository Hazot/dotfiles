# Kevin's aliases

# General aliases
alias mkdir="mkdir -p"
alias ..="cd .."
alias ...='cd ../..'
alias python="python3"
alias fd="fd --no-ignore"
alias rg="rg --no-ignore"

# Alias for listing directories?page=1 
alias ls="ls --color=auto"
alias ll="ls -lAh --group-directories-first --color=auto"
# alias ll="ls -alF --color=auto" # Equivalent to ls -la
alias la="ls -A --color=auto"
alias l="ls -ClF --group-directories-first --color=auto"
alias dir="dir --color=auto"
alias vdir="vdir --color=auto"

# Alias for ls that hides auxiliary LaTeX files
alias lst="ls -lh -I '*.aux' -I '*.bbl' -I '*.blg' -I '*.fdb_latexmk' -I '*.fls' -I '*.log' -I '*.out' -I '*.thm' -I '*.synctex.gz' --group-directories-first"

# Confirm before overwriting something
alias cp="cp -i"
alias mv="mv -i"
alias rm="rm -i"

# easier to read disk
alias df='df -h'     # human-readable sizes
alias free='free -m' # show sizes in MB

# Alias for "git status ."
alias gs='git status'
alias gits="git status ."

# Alias for "git status -uno ." (ignore untracked files)
alias guno="git status -uno"
alias gitsuno="git status -uno ."

# gpp
alias gpp="git pull && git push"

# Alias for git add
alias ga="git add"
alias gitu="git add -u ."
alias gita="git add --all" # same as "git add -A"
alias giat="git add --all" # same as "git add -A"

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
alias glogp="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative --no-merges"

# Alias for "git ls-tree -r master --name-only"
alias gitls="git ls-tree -r master --name-only"

# Other aliases
alias ju="jupyter notebook --no-browser"
alias julab="jupyter-lab --no-browser"
alias wk='workon'
alias dc='deactivate'

# Conda
alias ca='conda activate'
alias cdc='conda deactivate'
alias ctor='conda activate torch'
# And mamba
alias ma='mamba activate'
alias mdc='mamba deactivate'
alias mtor='mamba activate torch'


# File explorer
alias files='gio open'

