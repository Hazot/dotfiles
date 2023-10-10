# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

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

## Load scripts
[ -f "$HOME/.config/zsh/scripts.zsh" ] && source "$HOME/.config/zsh/scripts.zsh"

## Load aliases and shortcuts if existent.
[ -f "$HOME/.config/aliases.sh" ] && source "$HOME/.config/aliases.sh"
alias reload='source ~/.zshrc'

## More ZSH plugins for manjaro
# Load sudo: adds sudo after hitting escape twice
source ~/.zsh/zsh-sudo/sudo.plugin.zsh

# Julia
export PATH="$PATH:/home/hazot/julia-1.8.5/bin"

# Neovim
export PATH="$PATH:/home/hazot/.nvim/lua_ls/bin/"

## Virtualenvwrapper
export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3
export VIRTUALENVWRAPPER_VIRTUALENV=/home/hazot/.local/bin/
export WORKON_HOME=$HOME/.virtualenvs
source /home/hazot/.local/bin/virtualenvwrapper.sh

## Tex Live Path
export PATH="/usr/local/texlive/2023/bin/x86_64-linux:$PATH"


# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/hazot/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
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

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
