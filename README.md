# dotfiles

These are most of my configurations files. My aliases are in ``~/.config/aliases.sh``.

The ``main`` branch is for WSL.

The ``ubuntu`` branch was not used for a while since I am mostly active on the ``manjaro`` for fun right now. 

The ``manjaro`` branch already has a ``manjaro-zsh-config`` file with default stuff not present in ``.zshrc``.

## Requirements

1. Need to use ``git clone https://github.com/Hazot/dotfiles.git .`` or git clone and then move files all files and hidden files accordingly.
3. Need to install p10k and customize it however you like.
2. Need to git clone the following zsh plugins in ``$HOME/.zsh/``: 
    - zsh-syntax-highlighting
    - zsh-history-substring-search
    - zsh-autosuggestions
    - zsh-sudo

## TODO
- [ ] work on symlinks for rc files and work on .gitignore
- [ ] want to make a script to automatically download the 4 above plugins for zsh quick install
- [ ] work on a new lua config for WSL (can copy a lot from ``manjaro``)
- [ ] make python lsp work better on nvim
- [ ] add latex stuff

## Note
If old api keys appear in git history, they have been replaced since then.
