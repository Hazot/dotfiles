#!/usr/bin/env bash
# GNOME keybindings (Linux only). Run by hand: bash ~/dotfiles/gnome_keybinds.sh
# GNOME defaults are kept next to the custom bindings.
set -euo pipefail

command -v gsettings >/dev/null || { echo "gsettings not found (GNOME only)" >&2; exit 1; }

WM=org.gnome.desktop.wm.keybindings
MUTTER=org.gnome.mutter.keybindings

# Super+N: open Nth dock app, Ctrl+Super+N: go to workspace N
for i in $(seq 1 9); do
    gsettings set org.gnome.shell.keybindings switch-to-application-${i} "['<Super>${i}']"
    gsettings set $WM switch-to-workspace-${i} "['<Control><Super>${i}']"
done

# Ctrl+Super+hjkl: tile left, restore, maximize, tile right
gsettings set $MUTTER toggle-tiled-left  "['<Super>Left', '<Control><Super>h']"
gsettings set $WM     unmaximize         "['<Super>Down', '<Alt>F5', '<Control><Super>j']"
gsettings set $WM     maximize           "['<Super>Up', '<Control><Super>k']"
gsettings set $MUTTER toggle-tiled-right "['<Super>Right', '<Control><Super>l']"

# Shift+Ctrl+Super+hjkl: move window to the monitor left, down, up, right
gsettings set $WM move-to-monitor-left  "['<Shift><Super>Left', '<Shift><Control><Super>h']"
gsettings set $WM move-to-monitor-down  "['<Shift><Super>Down', '<Shift><Control><Super>j']"
gsettings set $WM move-to-monitor-up    "['<Shift><Super>Up', '<Shift><Control><Super>k']"
gsettings set $WM move-to-monitor-right "['<Shift><Super>Right', '<Shift><Control><Super>l']"

# Super+Alt+h/l: go to workspace left/right, add Shift to take the window along
gsettings set $WM switch-to-workspace-left  "['<Super>Page_Up', '<Super><Alt>Left', '<Control><Alt>Left', '<Super><Alt>h']"
gsettings set $WM switch-to-workspace-right "['<Super>Page_Down', '<Super><Alt>Right', '<Control><Alt>Right', '<Super><Alt>l']"
gsettings set $WM move-to-workspace-left    "['<Shift><Super>Page_Up', '<Shift><Super><Alt>Left', '<Shift><Control><Alt>Left', '<Shift><Super><Alt>h']"
gsettings set $WM move-to-workspace-right   "['<Shift><Super>Page_Down', '<Shift><Super><Alt>Right', '<Shift><Control><Alt>Right', '<Shift><Super><Alt>l']"

# Super+E: open home folder
gsettings set org.gnome.settings-daemon.plugins.media-keys home "['<Super>e']"

echo "Done"
