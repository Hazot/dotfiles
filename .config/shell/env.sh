# Environment shared by zsh, bash and sh login shells (POSIX sh, no bashisms).
# Every entry is guarded: nothing is added if the tool is not installed.

# Prepend a dir to PATH if it exists and is not already there
path_add() {
    [ -d "$1" ] || return 0
    case ":$PATH:" in
        *":$1:"*) ;;
        *) PATH="$1:$PATH" ;;
    esac
}

# Homebrew (macOS arm64, macOS intel, Linuxbrew)
for _brew in /opt/homebrew/bin/brew /usr/local/bin/brew /home/linuxbrew/.linuxbrew/bin/brew; do
    if [ -x "$_brew" ]; then
        eval "$("$_brew" shellenv)"
        break
    fi
done
unset _brew

# Language toolchains
path_add "$HOME/go/bin"
path_add "$HOME/.cargo/bin"
path_add "$HOME/.juliaup/bin"
path_add "$HOME/.pixi/bin"
path_add "$HOME/.opencode/bin"
path_add "$HOME/.cache/lm-studio/bin"
path_add "/Library/TeX/texbin"

# Pyenv
export PYENV_ROOT="$HOME/.pyenv"
path_add "$PYENV_ROOT/bin"

# nvm (loaded by the rc files, only the dir here)
export NVM_DIR="$HOME/.nvm"

# Local bins first
path_add "$HOME/bin"
path_add "$HOME/.local/bin"
export PATH

# Editor
if command -v nvim >/dev/null 2>&1; then
    export EDITOR=nvim
else
    export EDITOR=vim
fi
export VISUAL="$EDITOR"

# RCLONE
export RCLONE_BETA_FEATURES=bisync
