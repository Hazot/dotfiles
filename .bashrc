# ~/.bashrc: executed by bash(1) for non-login shells.

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes
force_python_prompt=no

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=no
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h \[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u \w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# Configured prompt in python for bash)
if [ "$force_python_prompt" = yes ]; then
    export PROMPT_COMMAND='PS1="$(python ~/.config/bash.config.color.py)"'
fi

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# Alias definitions (uses the same file as .zshrc)
if [ -r $HOME/.config/aliases.sh ]; then
    . $HOME/.config/aliases.sh
fi
# Exports (uses the same file as .zshrc)
if [ -r $HOME/.config/exports.sh ]; then
    . $HOME/.config/exports.sh
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Bash history pressing arrows
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'

# mkcdir: create directory and change directory into it
mkcdir ()
{
    mkdir -p -- "$1" &&
    cd -P -- "$1"
}

# rmlatex: remove *.aux, *.bbl, *.blg, *.out, *.log, *.fls, *fdb_latexmk files
rmlatex ()
{
    rm $(find '.' -maxdepth 1 | grep -E "$1"".*((aux)|(bbl)|(blg)|(out)|(thm)|(synctex.gz)|(log)|(fls)|(fdb_latexmk))")
}

# compile latex: pdflatex > bibtex (x2) > pdflatex (x2)
compilelatex ()
{
    pdflatex $1"tex" &&
    bibtex $1"aux" &&
    bibtex $1"aux" &&
    pdflatex $1"tex" &&
    pdflatex $1"tex"
}



### SCRIPTS

## Load scripts
[ -f "$HOME/.config/zsh/scripts.zsh" ] && source "$HOME/.config/zsh/scripts.zsh"

## Load aliases and shortcuts if existent.
[ -f "$HOME/.config/aliases.sh" ] && source "$HOME/.config/aliases.sh"
alias reload='source ~/.zshrc'

## Load exports and shortcuts if existent.
[ -f "$HOME/.config/exports.sh" ] && source "$HOME/.config/exports.sh"

### EXPORTS 

# Virtualenvwrapper
export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3
export VIRTUALENVWRAPPER_VIRTUALENV=/usr/local/bin/virtualenv
export WORKON_HOME=$HOME/.virtualenvs
source /usr/local/bin/virtualenvwrapper.sh

# CUDA
export PATH=/usr/local/cuda/bin${PATH:+:${PATH}}
export LD_LIBRARY_PATH=/usr/local/cuda-12.2/lib64${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}

# Neovim export path
export PATH="$PATH:/opt/nvim-linux64/bin"

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# node
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

# Nvidia OpenGL instead of Mesa 3D 
export LIBGL_ALWAYS_INDIRECT=0
. "$HOME/.cargo/env"



### MAMBA (CONDA)

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/hazot/miniforge3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/hazot/miniforge3/etc/profile.d/conda.sh" ]; then
        . "/home/hazot/miniforge3/etc/profile.d/conda.sh"
    else
        export PATH="/home/hazot/miniforge3/bin:$PATH"
    fi
fi
unset __conda_setup

if [ -f "/home/hazot/miniforge3/etc/profile.d/mamba.sh" ]; then
    . "/home/hazot/miniforge3/etc/profile.d/mamba.sh"
fi
# <<< conda initialize <<<



# >>> juliaup initialize >>>

# !! Contents within this block are managed by juliaup !!

case ":$PATH:" in
    *:/home/hazot/.juliaup/bin:*)
        ;;

    *)
        export PATH=/home/hazot/.juliaup/bin${PATH:+:${PATH}}
        ;;
esac

# <<< juliaup initialize <<<

# Created by `pipx` on 2024-09-09 04:10:58
export PATH="$PATH:/home/hazot/.local/bin"
