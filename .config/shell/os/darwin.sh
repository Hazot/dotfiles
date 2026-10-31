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
