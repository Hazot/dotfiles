## Kevin's config for the zoomer shell

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Enable colors and change prompt:
autoload -U colors && colors
# PS1="%{$fg[magenta]%}%n%{$fg[magenta]%}@%{$fg[magenta]%}%M %{$fg[blue]%}%~%{$fg[red]%}%{$reset_color%}$%b "
# PROMPT='%(?..%F{red}%?%f:)%F{blue}%n%f:%F{green}%{${PWD/#$HOME/~}%} %(!.%F{red}.%f)%# %f'
# PS1='%(?..%F{red}%?%f:)%F{blue}%n%f:%F{green}${PWD/#$HOME/~} %(!.%F{red}.%f)%# %f'

setopt autocd		# Automatically cd into typed directory.

## Options section
setopt correct                                                  # Auto correct mistakes
setopt extendedglob                                             # Extended globbing. Allows using regular expressions with *
setopt nocaseglob                                               # Case insensitive globbing
setopt rcexpandparam                                            # Array expension with parameters
setopt nocheckjobs                                              # Don't warn about running processes when exiting
setopt numericglobsort                                          # Sort filenames numerically when it makes sense
setopt nobeep                                                   # No beep
setopt appendhistory                                            # Immediately append history instead of overwriting
setopt histignorealldups                                        # If a new command is a duplicate, remove the older one
setopt autocd                                                   # if only directory path is entered, cd there.
setopt inc_append_history                                       # save commands are added to the history immediately, otherwise only when shell exits.
setopt histignorespace                                          # Don't save commands that start with space

zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' # Case insensitive tab completion
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"         # Colored completion (different colors for dirs/files/etc)
zstyle ':completion:*' rehash true                              # automatically find new executables in path 
zstyle ':completion:*' menu select                              # Highlight menu selection
# Speed up completions
zstyle ':completion:*' accept-exact '*(N)'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache
HISTFILE=~/.zhistory
HISTSIZE=10000
SAVEHIST=10000
export EDITOR=vim
WORDCHARS=${WORDCHARS//\/[&.;]}                                 # Don't consider certain characters part of the word

## Keybindings section
bindkey -e
bindkey '^[[7~' beginning-of-line                               # Home key
bindkey '^[[H' beginning-of-line                                # Home key
if [[ "${terminfo[khome]}" != "" ]]; then
  bindkey "${terminfo[khome]}" beginning-of-line                # [Home] - Go to beginning of line
fi
bindkey '^[[8~' end-of-line                                     # End key
bindkey '^[[F' end-of-line                                     # End key
if [[ "${terminfo[kend]}" != "" ]]; then
  bindkey "${terminfo[kend]}" end-of-line                       # [End] - Go to end of line
fi
bindkey '^[[2~' overwrite-mode                                  # Insert key
bindkey '^[[3~' delete-char                                     # Delete key
bindkey '^[[C'  forward-char                                    # Right key
bindkey '^[[D'  backward-char                                   # Left key
bindkey '^[[5~' history-beginning-search-backward               # Page up key
bindkey '^[[6~' history-beginning-search-forward                # Page down key

# Navigate words with ctrl+arrow keys
bindkey '^[Oc' forward-word                                     #
bindkey '^[Od' backward-word                                    #
bindkey '^[[1;5D' backward-word                                 #
bindkey '^[[1;5C' forward-word                                  #
bindkey '^H' backward-kill-word                                 # delete previous word with ctrl+backspace
bindkey '^[[Z' undo                                             # Shift+tab undo last action

# Theming section  
autoload -U compinit colors zcalc
compinit -d
colors

## Load scripts
[ -f "$HOME/.config/zsh/scripts.zsh" ] && source "$HOME/.config/zsh/scripts.zsh"

## Load aliases and shortcuts if existent.
[ -f "$HOME/.config/aliases.sh" ] && source "$HOME/.config/aliases.sh"
alias reload='source ~/.zshrc'

## Load exports and shortcuts if existent.
[ -f "$HOME/.config/exports.sh" ] && source "$HOME/.config/exports.sh"

## Duckietown stuff
export IP=$(ifconfig en0 | grep inet | awk '$1=="inet" {print $2}')

## Path (added for duckietown)
export PATH=~/.local/bin:${PATH}

## Add go bin to path
export PATH=$PATH:$(go env GOPATH)/bin

## Path for local custom bins
export PATH="~/bin:${PATH}"

## Default Programming Language versions:
export PATH="/opt/homebrew/opt/lua@5.4/bin:$PATH"
export PATH="/opt/homebrew/opt/python@3.12/bin:$PATH"



## Virtualenvwrapper
# export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3
# export VIRTUALENVWRAPPER_VIRTUALENV=/usr/local/bin/virtualenv
# export WORKON_HOME=$HOME/.virtualenvs
# source /usr/local/bin/virtualenvwrapper.sh

## Plugins section
# Load zsh-syntax-highlighting; should be last.
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Use history substring search
source ~/.zsh/zsh-history-substring-search/zsh-history-substring-search.zsh
# bind UP and DOWN arrow keys to history substring search
zmodload zsh/terminfo
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down
bindkey '^[[A' history-substring-search-up			
bindkey '^[[B' history-substring-search-down

# Use autosuggestions
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

# Load sudo: adds sudo after hitting escape twice
source ~/.zsh/zsh-sudo/sudo.plugin.zsh

# Load zsh-z to jump around directories quickly
source ~/.zsh/zsh-z/zsh-z.plugin.zsh

## p10k stuff
source ~/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Export keys 
if [ -r $HOME/.config/keys.sh ]; then
    . $HOME/.config/keys.sh
fi

# export flutter dev bin
export PATH="$PATH:$HOME/development/flutter/bin"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Tmp/lessarke/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Tmp/lessarke/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/Tmp/lessarke/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Tmp/lessarke/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# >>> Mamba initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/hazot/mambaforge/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/hazot/mambaforge/etc/profile.d/conda.sh" ]; then
        . "/Users/hazot/mambaforge/etc/profile.d/conda.sh"
    else
        export PATH="/Users/hazot/mambaforge/bin:$PATH"
    fi
fi
unset __conda_setup

if [ -f "/Users/hazot/mambaforge/etc/profile.d/mamba.sh" ]; then
    . "/Users/hazot/mambaforge/etc/profile.d/mamba.sh"
fi
# <<< Mamba initialize <<<
#

# >>> juliaup initialize >>>

# !! Contents within this block are managed by juliaup !!

path=('/Users/hazot/.juliaup/bin' $path)
export PATH

# <<< juliaup initialize <<<

# Added by LM Studio CLI (lms)
export PATH="$PATH:/Users/hazot/.cache/lm-studio/bin"
# End of LM Studio CLI section

