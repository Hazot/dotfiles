#!/usr/bin/env bash
# GNOME keybindings (Linux only). Run by hand: bash ~/dotfiles/linux/gnome_keybinds.sh
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
# Ubuntu's Tiling Assistant extension empties the mutter/wm versions of these keys
# every time it is enabled (each login), so set them on the extension when it is enabled.
TA=org.gnome.shell.extensions.tiling-assistant
if gnome-extensions list --enabled 2>/dev/null | grep -qx 'tiling-assistant@ubuntu.com'; then
    gsettings set $TA tile-left-half  "['<Super>Left', '<Super>KP_4', '<Control><Super>h']"
    gsettings set $TA restore-window  "['<Super>Down', '<Control><Super>j']"
    gsettings set $TA tile-maximize   "['<Super>Up', '<Super>KP_5', '<Control><Super>k']"
    gsettings set $TA tile-right-half "['<Super>Right', '<Super>KP_6', '<Control><Super>l']"
else
    gsettings set $MUTTER toggle-tiled-left  "['<Super>Left', '<Control><Super>h']"
    gsettings set $WM     unmaximize         "['<Super>Down', '<Alt>F5', '<Control><Super>j']"
    gsettings set $WM     maximize           "['<Super>Up', '<Control><Super>k']"
    gsettings set $MUTTER toggle-tiled-right "['<Super>Right', '<Control><Super>l']"
fi

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

# Shift+Super+S: screenshot UI (replaces the default Print key)
gsettings set org.gnome.shell.keybindings show-screenshot-ui "['<Shift><Super>s']"

# Super+N: notification list (default Super+V). Frees Super+N from focus-active-notification.
gsettings set org.gnome.shell.keybindings focus-active-notification "[]"
gsettings set org.gnome.shell.keybindings toggle-message-tray "['<Super>n', '<Super>m']"

# Super+V: GPaste clipboard history (default Ctrl+Alt+H)
if gsettings list-schemas | grep -qx org.gnome.GPaste; then
    gsettings set org.gnome.GPaste show-history '<Super>v'
fi

# Super+E: open home folder
gsettings set org.gnome.settings-daemon.plugins.media-keys home "['<Super>e']"

echo "Done"
