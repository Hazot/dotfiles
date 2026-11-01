#!/usr/bin/env bash
# Full machine install (macOS + Ubuntu/Debian): link dotfiles, then ask per group.
#   ~/dotfiles/install.sh        ask y/n for each group
#   ~/dotfiles/install.sh -y     yes to everything
set -euo pipefail

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP="$HOME/.dotfiles-backup/$(date +%Y%m%d-%H%M%S)"
YES=0
[[ "${1:-}" == "-y" ]] && YES=1

# Files in the repo that are not linked into ~
EXCLUDE=(
    install.sh minimal_install.sh update.sh README.md LICENSE .gitignore
    linux/% .github/% .config/wsl/% .config/shell/local.sh.example
)

info() { printf '\033[1;34m>>> %s\033[0m\n' "$*"; }
warn() { printf '\033[1;33m!!! %s\033[0m\n' "$*" >&2; }

ask() {
    [[ $YES -eq 1 ]] && return 0
    local reply
    # Prompt on the tty directly: read -p writes to stderr, which is silenced here
    { printf '%s [y/N] ' "$1" >/dev/tty && read -r reply </dev/tty; } 2>/dev/null || return 1
    [[ "$reply" =~ ^[Yy]$ ]]
}

# Symlink SRC to DST, backing up any real file already there
link() {
    local src=$1 dst=$2
    [[ "$(readlink "$dst" 2>/dev/null)" == "$src" ]] && return 0
    if [[ -e "$dst" || -L "$dst" ]]; then
        mkdir -p "$BACKUP/$(dirname "${dst#"$HOME"/}")"
        mv "$dst" "$BACKUP/${dst#"$HOME"/}"
    fi
    mkdir -p "$(dirname "$dst")"
    ln -s "$src" "$dst"
    echo "linked ~/${dst#"$HOME"/}"
}

excluded() {
    local f=$1 e
    [[ "$f" == *.DS_Store ]] && return 0
    for e in "${EXCLUDE[@]}"; do
        if [[ "$e" == *% ]]; then
            [[ "$f" == "${e%\%}"* ]] && return 0
        else
            [[ "$f" == "$e" ]] && return 0
        fi
    done
    return 1
}

clone_if_missing() {
    local url=$1 dst=$2
    if [[ -e "$dst" ]]; then
        echo "exists, skipping: $dst"
    else
        git clone --depth=1 "$url" "$dst"
    fi
}

# Third-party code is pinned to a reviewed commit: bump the SHA to update
clone_pinned() {
    local url=$1 dst=$2 sha=$3
    if [[ -e "$dst" ]]; then
        echo "exists, skipping: $dst"
        return 0
    fi
    git init -q "$dst"
    git -C "$dst" remote add origin "$url"
    git -C "$dst" fetch -q --depth=1 origin "$sha"
    git -C "$dst" checkout -q FETCH_HEAD
    echo "cloned $url @ ${sha:0:7}"
}

# OS detection
case "$(uname -s)" in
    Darwin)
        OS=macos
        command -v brew >/dev/null || {
            warn "Homebrew missing, installing it"
            /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
            eval "$(/opt/homebrew/bin/brew shellenv 2>/dev/null || /usr/local/bin/brew shellenv)"
        }
        pkg() { brew install "$@"; }
        ;;
    Linux)
        command -v apt-get >/dev/null || { warn "Only apt-based Linux is supported for now"; exit 1; }
        OS=ubuntu
        SUDO=""
        [[ $EUID -ne 0 ]] && SUDO=sudo
        APT_UPDATED=0
        pkg() {
            [[ $APT_UPDATED -eq 0 ]] && { $SUDO apt-get update; APT_UPDATED=1; }
            $SUDO apt-get install -y "$@"
        }
        ;;
    *) warn "Unsupported OS: $(uname -s)"; exit 1 ;;
esac
info "Detected $OS, dotfiles in $DOTFILES"

# 0. Links (always)
info "Linking dotfiles into ~"
while IFS= read -r f; do
    excluded "$f" && continue
    link "$DOTFILES/$f" "$HOME/$f"
done < <(git -C "$DOTFILES" ls-files)
link "$HOME/.config/tmux/tmux.conf" "$HOME/.tmux.conf"
[[ -d "$BACKUP" ]] && warn "Replaced files backed up in $BACKUP"

# 1. Core
if ask "Install core packages (git curl zsh tmux bash-completion)?"; then
    info "Installing core packages"
    if [[ $OS == macos ]]; then
        pkg git zsh tmux bash-completion@2
    else
        pkg git curl zsh tmux bash-completion
    fi
fi

# 2. zsh plugins + p10k
if ask "Install zsh plugins + powerlevel10k?"; then
    info "Installing zsh plugins"
    mkdir -p ~/.zsh
    clone_pinned https://github.com/zsh-users/zsh-history-substring-search.git ~/.zsh/zsh-history-substring-search \
        a0bdb0d47dbaba31dba2db7af8c48a5d9c74049a
    clone_pinned https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh/zsh-syntax-highlighting \
        e6683f20e5c38d3e5447f45845d04ddda75d0f23
    clone_pinned https://github.com/zsh-users/zsh-autosuggestions.git ~/.zsh/zsh-autosuggestions \
        85919cd1ffa7d2d5412f6d3fe437ebdbeeec4fc5
    clone_pinned https://github.com/agkozak/zsh-z.git ~/.zsh/zsh-z \
        7f8ff4df11b50a14e3666c7cd212baa399c9b92a
    if [[ ! -f ~/.zsh/zsh-sudo/sudo.plugin.zsh ]]; then
        mkdir -p ~/.zsh/zsh-sudo
        curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/964ddf789b022b6958b27d02d7fa54f552de21e9/plugins/sudo/sudo.plugin.zsh \
            -o ~/.zsh/zsh-sudo/sudo.plugin.zsh
    fi
    clone_pinned https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k \
        d05a1b00f9a61f9578bf9dc19b8451942dde8734
fi

# 3. tmux plugins
if ask "Install tmux plugin manager (tpm) and plugins?"; then
    info "Installing tpm and the plugins listed in tmux.conf"
    clone_pinned https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm \
        e261deb1b47614eed3400089ce7197dc68acc4eb
    if command -v tmux >/dev/null; then
        ~/.tmux/plugins/tpm/bin/install_plugins
    else
        warn "tmux missing: install it, then prefix + I inside tmux"
    fi
fi

# 4. Neovim
if ask "Install Neovim + deps (ripgrep, fd, node) and clone Hazot/nvim?"; then
    info "Installing Neovim"
    if [[ $OS == macos ]]; then
        pkg neovim ripgrep fd
    else
        pkg neovim ripgrep fd-find
        mkdir -p ~/.local/bin
        if ! command -v fd >/dev/null && command -v fdfind >/dev/null; then
            ln -sf "$(command -v fdfind)" ~/.local/bin/fd
        fi
    fi
    if [[ ! -s "$HOME/.nvm/nvm.sh" ]]; then
        PROFILE=/dev/null bash -c "$(curl -fsSL https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh)"
    fi
    # shellcheck disable=SC1091
    . "$HOME/.nvm/nvm.sh" && nvm install --lts
    clone_if_missing git@github.com:Hazot/nvim.git ~/.config/nvim
fi

# 5. Sioyek config
if ask "Clone Hazot/sioyek config?"; then
    clone_if_missing git@github.com:Hazot/sioyek.git ~/.config/sioyek
fi

# 6. Dev extras
if ask "Install dev extras (rustup, uv, pixi, pipx)?"; then
    info "Installing dev extras"
    command -v rustup >/dev/null || curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --no-modify-path
    command -v uv >/dev/null || curl -LsSf https://astral.sh/uv/install.sh | env UV_NO_MODIFY_PATH=1 sh
    command -v pixi >/dev/null || curl -fsSL https://pixi.sh/install.sh | PIXI_NO_PATH_UPDATE=1 bash
    command -v pipx >/dev/null || pkg pipx
fi

# 7. Default shell
if [[ "$(basename "${SHELL:-}")" != zsh ]] && command -v zsh >/dev/null; then
    if ask "Make zsh the default shell?"; then
        # Directory accounts (AD/LDAP via SSSD) are not in /etc/passwd, chsh can't change them
        if [[ $OS == ubuntu ]] && ! grep -q "^$(id -un):" /etc/passwd; then
            warn "$(id -un) is a directory account, chsh can't change its shell. Add to ~/.config/shell/local.sh:"
            warn '  [ -n "$BASH_VERSION" ] && [[ $- == *i* ]] && command -v zsh >/dev/null && exec zsh'
        else
            chsh -s "$(command -v zsh)" || warn "chsh failed, shell unchanged"
        fi
    fi
fi

info "Done. Machine-specific settings: cp ~/dotfiles/.config/shell/local.sh.example ~/.config/shell/local.sh"
