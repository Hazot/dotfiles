#!/usr/bin/env bash
# GNOME settings (Linux only). Run by hand: bash ~/dotfiles/linux/gnome_settings.sh
set -euo pipefail

command -v gsettings >/dev/null || { echo "gsettings not found (GNOME only)" >&2; exit 1; }

MOUSE=org.gnome.desktop.peripherals.mouse
TOUCHPAD=org.gnome.desktop.peripherals.touchpad

# Mouse: speed goes from -1 to 1, flat means no acceleration
gsettings set $MOUSE speed 0.075
gsettings set $MOUSE accel-profile 'flat'

# Touchpad
gsettings set $TOUCHPAD speed 0.1
gsettings set $TOUCHPAD natural-scroll true
gsettings set $TOUCHPAD two-finger-scrolling-enabled true
gsettings set $TOUCHPAD tap-to-click true

# Touchpad acceleration off. Older GNOME versions don't have this key.
if gsettings writable $TOUCHPAD accel-profile >/dev/null 2>&1; then
    gsettings set $TOUCHPAD accel-profile 'flat'
else
    echo "$TOUCHPAD accel-profile not available on this GNOME, acceleration unchanged" >&2
fi

echo "Done"
