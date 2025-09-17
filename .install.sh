#!/usr/bin/env bash
set -e # exit on error

# RUST TOOLS
echo ">>> Installing Rust tools..."
if ! command -v rustup >/dev/null; then
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
    source $HOME/.cargo/env
else
    rustup update
fi

if ! command -v rg >/dev/null; then
    cargo install ripgrep
fi

if ! command -v fd >/dev/null; then
    cargo install fd-find
fi

echo -e ">>> Rust tools installed!\n"

# P10K
echo ">>> Installing Powerlevel10k..."
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k || echo "Already exists, skipping."
echo -e "Powerlevel10k installed!\n"

# ZSH PLUGINS
echo ">>> Installing Zsh plugins..."

# Ensure plugin dir exists
mkdir -p ~/.zsh

echo "Cloning zsh-history-substring-search..."
git clone https://github.com/zsh-users/zsh-history-substring-search.git ~/.zsh/zsh-history-substring-search || echo "Already exists, skipping."

echo "Cloning zsh-syntax-highlighting..."
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh/zsh-syntax-highlighting || echo "Already exists, skipping."

echo "Cloning zsh-autosuggestions..."
git clone https://github.com/zsh-users/zsh-autosuggestions.git ~/.zsh/zsh-autosuggestions || echo "Already exists, skipping."

echo "Cloning zsh-z..."
git clone https://github.com/agkozak/zsh-z.git ~/.zsh/zsh-z || echo "Already exists, skipping."

echo "Downloading sudo.plugin.zsh..."
mkdir -p ~/.zsh/zsh-sudo
curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/plugins/sudo/sudo.plugin.zsh \
    -o ~/.zsh/zsh-sudo/sudo.plugin.zsh

echo -e ">>> All plugins installed!"
