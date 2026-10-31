#!/usr/bin/env bash
# Minimal install for Linux VMs / servers: bash, readline, tmux, vim and git config.
# Installs no packages, only places config files (existing ones are backed up).
#
#   curl -fsSL https://raw.githubusercontent.com/Hazot/dotfiles/main/minimal_install.sh | bash
#       download the files into ~ (no git needed)
#   ~/dotfiles/minimal_install.sh --link
#       symlink them from a (sparse) clone of the repo, update later with git pull
set -euo pipefail

REPO_RAW="${DOTFILES_RAW:-https://raw.githubusercontent.com/Hazot/dotfiles/main}"
BACKUP="$HOME/.dotfiles-backup/$(date +%Y%m%d-%H%M%S)"
FILES=(
    .bashrc
    .bash_profile
    .profile
    .vimrc
    .gitconfig
    .config/bash/inputrc
    .config/shell/aliases.sh
    .config/shell/env.sh
    .config/shell/os/linux.sh
    .config/shell/local.sh.example
    .config/tmux/tmux.conf
    .config/git/ignore
)

backup() {
    local dst=$1
    [[ -e "$dst" || -L "$dst" ]] || return 0
    mkdir -p "$BACKUP/$(dirname "${dst#"$HOME"/}")"
    mv "$dst" "$BACKUP/${dst#"$HOME"/}"
}

mode=download
[[ "${1:-}" == "--link" ]] && mode=link
src_dir="$(cd "$(dirname "${BASH_SOURCE[0]:-.}")" 2>/dev/null && pwd || true)"

if [[ $mode == link && ! -f "$src_dir/.bashrc" ]]; then
    echo "--link must be run from a clone of the repo (missing $src_dir/.bashrc)" >&2
    exit 1
fi
if [[ $mode == download ]] && ! command -v curl >/dev/null && ! command -v wget >/dev/null; then
    echo "Need curl or wget" >&2
    exit 1
fi

fetch() {
    if command -v curl >/dev/null; then curl -fsSL "$1" -o "$2"; else wget -qO "$2" "$1"; fi
}

for f in "${FILES[@]}"; do
    dst="$HOME/$f"
    mkdir -p "$(dirname "$dst")"
    if [[ $mode == link ]]; then
        [[ "$(readlink "$dst" 2>/dev/null)" == "$src_dir/$f" ]] && continue
        backup "$dst"
        ln -s "$src_dir/$f" "$dst"
    else
        tmp=$(mktemp)
        fetch "$REPO_RAW/$f" "$tmp"
        backup "$dst"
        mv "$tmp" "$dst"
        chmod 644 "$dst"
    fi
    echo "$mode: ~/$f"
done

# Old tmux (< 3.1) only reads ~/.tmux.conf
if [[ "$(readlink "$HOME/.tmux.conf" 2>/dev/null)" != "$HOME/.config/tmux/tmux.conf" ]]; then
    backup "$HOME/.tmux.conf"
    ln -s "$HOME/.config/tmux/tmux.conf" "$HOME/.tmux.conf"
fi

[[ -d "$BACKUP" ]] && echo "Replaced files backed up in $BACKUP"
echo "Done. Start a new shell or run: source ~/.bashrc"
