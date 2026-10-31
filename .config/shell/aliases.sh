# Kevin's aliases (shared by zsh and bash, OS-specific ones in os/*.sh)

# Claude Code: plain `claude` uses ~/.claude (org account, single login).
# `claude-pro` uses a separate config dir for the personal Pro account.
alias claude-pro='CLAUDE_CONFIG_DIR="$HOME/.claude-pro" claude'

# Claude Code status line toggle
alias sl-cc='touch ~/.claude/use-ccstatusline'
alias sl-mine='rm -f ~/.claude/use-ccstatusline'

# Dotfiles
alias dfu='~/dotfiles/update.sh'
alias dfs='git -C ~/dotfiles status -s'

# General aliases
alias mkdir="mkdir -p"
alias ..="cd .."
alias ...="cd ../.."
alias python="python3"
alias fd="fd --no-ignore"
alias rg="rg --no-ignore"
command -v nvim >/dev/null 2>&1 && alias vim="nvim"

# mkdir + cd
mkcd() { mkdir -p -- "$1" && cd -P -- "$1"; }

# Alias for listing directories
alias ls="ls --color=auto"
alias ll="ls -lAh --color=auto"
alias la="ls -A --color=auto"
alias l="ls -ClF --color=auto"

# Confirm before overwriting something
alias cp="cp -i"
alias mv="mv -i"
alias rm="rm -i"

# easier to read disk
alias df='df -h'

# Alias for "git status"
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

# Alias for "git branch"
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

# Alias for "git ls-tree -r main --name-only"
alias gitls="git ls-tree -r HEAD --name-only"

# Jupyter
alias ju="jupyter notebook --no-browser"
alias julab="jupyter lab --no-browser"

# Python
alias sov='source .venv/bin/activate'
alias wk='workon'
alias dc='deactivate'

# Conda
alias ca='conda activate'
alias cdc='conda deactivate'
alias ctf='conda activate tf'
alias ctor='conda activate torch'
# And mamba
alias ma='mamba activate'
alias mdc='mamba deactivate'
alias mtor='mamba activate torch'

# Old aliases
alias udem='cd ~/code/udem/'
alias ghub='cd ~/code/github/'
alias h='cd ~'
alias home='cd ~'

# work
alias wksp='cd ~/work/code/'
