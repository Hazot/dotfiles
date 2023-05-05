# Use powerline
USE_POWERLINE="true"
# Source manjaro-zsh-configuration
if [[ -e /usr/share/zsh/manjaro-zsh-config ]]; then
  source /usr/share/zsh/manjaro-zsh-config
fi
# Use manjaro zsh prompt
if [[ -e /usr/share/zsh/manjaro-zsh-prompt ]]; then
  source /usr/share/zsh/manjaro-zsh-prompt
fi

# Alias for "ls -lAh"
alias lsa="ls -lAh --group-directories-first"
alias ll="ls -lAh --group-directories-first"

# Alias for "ls -lh -I '*.pyc' -I '*.sw*'"
alias lss="ls -lh -I '*.pyc' -I '*.sw*' --group-directories-first"

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
alias gaf="git fetch --all"

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

# Alias for "git ls-tree -r main --name-only"
alias gitls="git ls-tree -r main --name-only"

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

# Julia
export PATH="$PATH:/home/hazot/julia-1.8.5/bin"

# Ubuntu: open files
# alias files='nautilus'
alias files='gio open'
