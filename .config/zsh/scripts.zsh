## Useful scripts for zsh

# update and upgrade packages
function updapack(){
    sudo apt update
    apt list --upgradable
    sudo apt upgrade -y
}
