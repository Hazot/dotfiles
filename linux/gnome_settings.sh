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
gsettings set $TOUCHPAD speed 0.05
gsettings set $TOUCHPAD natural-scroll true
gsettings set $TOUCHPAD two-finger-scrolling-enabled true
gsettings set $TOUCHPAD tap-to-click true

# Touchpad keeps GNOME's default acceleration. Older GNOME versions don't have this key.
gsettings writable $TOUCHPAD accel-profile >/dev/null 2>&1 && gsettings reset $TOUCHPAD accel-profile

# GPaste clipboard manager (apt install gpaste-2 gnome-shell-extension-gpaste)
GPASTE=org.gnome.GPaste
if gsettings list-schemas | grep -qx "$GPASTE"; then
    gsettings set $GPASTE max-history-size 50
    gsettings set $GPASTE save-history false   # history is lost on logout, keeps copied secrets off disk
else
    echo "GPaste not installed, skipping its settings" >&2
fi

echo "Done"
