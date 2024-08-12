. ~/.bashrc
if [ -f "/Tmp/lessarke/.cargo/env" ]; then
    . "/Tmp/lessarke/.cargo/env"
fi
. "$HOME/.cargo/env"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/hazot/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/hazot/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/hazot/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/hazot/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup

if [ -f "/Users/hazot/miniconda3/etc/profile.d/mamba.sh" ]; then
    . "/Users/hazot/miniconda3/etc/profile.d/mamba.sh"
fi
# <<< conda initialize <<<

