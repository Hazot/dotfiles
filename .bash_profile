# Login shells (SSH, tmux, macOS Terminal): env from .profile, then interactive config
[ -f "$HOME/.profile" ] && . "$HOME/.profile"
[ -f "$HOME/.bashrc" ] && . "$HOME/.bashrc"
