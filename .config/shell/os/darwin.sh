# macOS-only aliases and functions (zsh and bash)

alias files='open'

# alias papers
alias paper='papers'

# update and upgrade packages using brew
updapack() {
    brew update
    brew upgrade

    brew outdated --cask --greedy --verbose
    brew upgrade --cask --greedy
}

# Stay awake with the lid closed, until Ctrl-C or the terminal closes.
# One root process does it all: restoring can't prompt for sudo once the terminal is gone.
awake() {
    sudo /bin/sh -c '
        trap "pmset -a disablesleep 0; echo \"Normal sleep restored.\"" EXIT
        trap "exit" HUP INT TERM
        pmset -a disablesleep 1
        echo "Staying awake (lid close ignored). Ctrl-C or close this terminal to stop."
        while kill -0 "$1" 2>/dev/null; do
            sleep 5 &
            wait $!
        done
    ' awake "$$"
}
