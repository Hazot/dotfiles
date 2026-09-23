# Kevin's aliases

# Claude Code: plain `claude` uses ~/.claude (org account, single login).
# `claude-pro` uses a separate config dir for the personal Pro account.
alias claude-pro='CLAUDE_CONFIG_DIR="$HOME/.claude-pro" claude'

# General aliases
alias mkdir="mkdir -p"
alias ..="cd .."
alias ...="cd ../.."
alias python='python3'
alias fd='fd --no-ignore'
alias rg='rg --no-ignore'

# Source venv fast
alias sov='source .venv/bin/activate'

# Alias for listing directories 
alias ls='ls --color=auto'
alias ll="ls -lAh --color=auto"
# alias ll="ls -alF --color=auto"
alias la="ls -A --color=auto"
alias l="ls -ClF --color=auto"
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'

# Confirm before overwriting something
alias cp="cp -i"
alias mv="mv -i"
alias rm="rm -i"

# Alias for "git status ."
# alias gs="git status" # Conflicts with ghostscript
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
alias glogp="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative --no-merges"

# Alias for "git ls-tree -r master --name-only"
alias gitls="git ls-tree -r master --name-only"

# Other aliases
alias ju="jupyter notebook --no-browser"
alias julab="jupyter lab --no-browser"
alias ca='conda activate'
alias ma='mamba activate'
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
alias files='open'

# alias papers
alias papers='/Users/hazot/Google\ Drive/My\ Drive/Learning/Readings/Papers'
alias paper='/Users/hazot/Google\ Drive/My\ Drive/Learning/Readings/Papers'

# Claude Code status line toggle
alias sl-cc='touch ~/.claude/use-ccstatusline'
alias sl-mine='rm -f ~/.claude/use-ccstatusline'
