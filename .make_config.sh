for i in $(seq 1 9)
do
    echo "['<Super>${i}']";
    gsettings set org.gnome.shell.keybindings switch-to-application-${i} "['<Super>${i}']";
    gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-${i} "['<Control><Super>${i}']";
done
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-${0} "['<Control><Super>${0}']";
echo "Done"