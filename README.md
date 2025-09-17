# dotfiles

These are most of my configuration files. My aliases are in ``~/.config/aliases.sh``.

The ``main`` branch is for currently used distro.

The ``wsl`` branch is for Windows WSl.

The ``macos`` branch is also always up-to-date.

The ``gentoo`` branch is not often updated, only sometimes when I use it.

The ``manjaro`` branch already has a ``manjaro-zsh-config`` file with default stuff not present in ``.zshrc``.

The ``arch`` branch will be coming soon.

---
The branches have diferent paths, package managers, etc. but try to emulate the same config accross systems.

## Requirements

1. Use ``git clone git@github.com:Hazot/dotfiles.git .`` then move files all files and hidden files accordingly.
2. Run ``sh ./.install.sh`` in your ``$HOME`` (may need to ``chmod +x .install.sh``)
3. Make sure that ``chsh -s $(which zsh)`` and restart your terminal
4. Enjoy!

## TODOs
- [x] make a script to automatically download the 5 above plugins for zsh quick install
- [x] make a script to automatically download rust tools (``ripgrep``, ``fd-find``)
- [ ] make only one branch with a setup file that creates a config depending on the OS
- [ ] add all required packages in there
- [ ] work on symlinks for rc files and work on .gitignore
- [ ] add latex stuff

## Note
If old api keys appear in git history, they have been replaced since then.
