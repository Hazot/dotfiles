## Useful scripts for zsh

# update and upgrade packages for macos using brew
function updapack(){
    brew update
    brew upgrade

    brew outdated --cask --greedy --verbose
    brew upgrade --cask --greedy
}
