# Linux-only aliases and functions (zsh and bash)

# GNU ls extras
alias ll="ls -lAh --group-directories-first --color=auto"
alias l="ls -ClF --group-directories-first --color=auto"
alias dir="dir --color=auto"
alias vdir="vdir --color=auto"
alias grep="grep --color=auto"

# Alias for ls that hides auxiliary LaTeX files
alias lst="ls -lh -I '*.aux' -I '*.bbl' -I '*.blg' -I '*.fdb_latexmk' -I '*.fls' -I '*.log' -I '*.out' -I '*.thm' -I '*.synctex.gz' --group-directories-first"

alias free='free -m'

# Debian/Ubuntu package names
if ! (
    unalias fd 2>/dev/null
    command -v fd >/dev/null 2>&1
) && command -v fdfind >/dev/null 2>&1; then
    alias fd="fdfind --no-ignore"
fi
command -v bat >/dev/null 2>&1 || ! command -v batcat >/dev/null 2>&1 || alias bat="batcat"

# File explorer
command -v gio >/dev/null 2>&1 && alias files='gio open'

# update and upgrade packages for ubuntu
updapack() {
    sudo apt update
    apt list --upgradable
    sudo apt upgrade -y
}

# Stay awake with the lid closed: for a command, or until Ctrl-C
awake() {
    local what="sleep:idle:handle-lid-switch"
    if (($#)); then
        systemd-inhibit --what=$what --why="awake: $*" "$@"
    else
        echo "Staying awake (lid close ignored). Ctrl-C to stop."
        systemd-inhibit --what=$what --why="awake" sleep infinity
    fi
}
