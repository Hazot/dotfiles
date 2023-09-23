## Useful scripts for zsh

# update and upgrade packages for ubuntu
function updapack(){
    sudo apt update
    apt list --upgradable
    sudo apt upgrade -y
}
