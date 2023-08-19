# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Kevin's config for the zoomer shell

# Enable colors and change prompt:
autoload -U colors && colors
# PS1="%{$fg[magenta]%}%n%{$fg[magenta]%}@%{$fg[magenta]%}%M %{$fg[blue]%}%~%{$fg[red]%}%{$reset_color%}$%b "
# PROMPT='%(?..%F{red}%?%f:)%F{blue}%n%f:%F{green}%{${PWD/#$HOME/~}%} %(!.%F{red}.%f)%# %f'
# PS1='%(?..%F{red}%?%f:)%F{blue}%n%f:%F{green}${PWD/#$HOME/~} %(!.%F{red}.%f)%# %f'

setopt autocd		# Automatically cd into typed directory.

# History in cache directory:
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.cache/zsh/history

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)		# Include hidden files.

# Load aliases and shortcuts if existent.
[ -f "$HOME/.config/aliases.sh" ] && source "$HOME/.config/aliases.sh"

# Virtualenvwrapper
export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3
export VIRTUALENVWRAPPER_VIRTUALENV=/usr/local/bin/virtualenv
export WORKON_HOME=$HOME/.virtualenvs
source /usr/local/bin/virtualenvwrapper.sh

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/hazot/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/hazot/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/hazot/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/hazot/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# Load zsh-syntax-highlighting; should be last.
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null
source ~/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
