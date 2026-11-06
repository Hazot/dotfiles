#!/usr/bin/env bash
# Caps Lock navigation layer with keyd (Linux only, needs sudo). Config: linux/keyd.conf
# Run by hand: bash ~/dotfiles/linux/keyd_setup.sh   (again after editing keyd.conf)
set -euo pipefail

CONF="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/keyd.conf"

# Ubuntu/Debian name the command keyd.rvaiya, so check the package instead
if ! dpkg -s keyd >/dev/null 2>&1; then
    echo "Installing keyd"
    sudo apt-get install -y keyd
fi

# Copied, not linked: keyd runs as root and /etc should not depend on a file in ~
sudo install -D -m 644 "$CONF" /etc/keyd/default.conf
sudo systemctl enable keyd
sudo systemctl restart keyd   # loads the new config

echo "Done: hold Caps + hjkl for arrows, tap Caps for Esc"
