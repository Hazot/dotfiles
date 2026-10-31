# dotfiles

My shell, tmux, vim and git configuration, one `main` branch for macOS and Ubuntu.
The repo lives in `~/dotfiles` and its files are symlinked into `~`.

Neovim and Sioyek configs are independent repos, cloned by the installer:

| Repo | Location |
|---|---|
| [Hazot/dotfiles](https://github.com/Hazot/dotfiles) | `~/dotfiles` |
| [Hazot/nvim](https://github.com/Hazot/nvim) | `~/.config/nvim` |
| [Hazot/sioyek](https://github.com/Hazot/sioyek) | `~/.config/sioyek` |

## Full machine (macOS, Ubuntu)

```sh
git clone git@github.com:Hazot/dotfiles.git ~/dotfiles
~/dotfiles/install.sh        # asks y/n for each group, -y for all
```

It links every file into `~` (existing files go to `~/.dotfiles-backup/<date>/`), then offers:
core packages, zsh plugins + powerlevel10k, tpm, Neovim (+ ripgrep, fd, node, `Hazot/nvim`),
`Hazot/sioyek`, dev extras (rustup, uv, pixi, pipx), zsh as default shell.
Repos are only cloned when missing, never pulled or overwritten.

Update everything later (skips repos that are dirty or not on `main`):

```sh
~/dotfiles/update.sh         # or: dfu
```

## Minimal (Linux VMs, servers)

Bash, readline, tmux, vim and git config only. Installs no packages.

```sh
# curl, no git needed
curl -fsSL https://raw.githubusercontent.com/Hazot/dotfiles/main/minimal_install.sh | bash

# sparse clone, updatable with git pull
git clone --depth=1 --filter=blob:none --sparse https://github.com/Hazot/dotfiles.git ~/dotfiles
git -C ~/dotfiles sparse-checkout set --no-cone /minimal_install.sh /.bashrc /.bash_profile /.profile /.vimrc /.gitconfig /.config/bash /.config/shell /.config/tmux/tmux.conf /.config/git
~/dotfiles/minimal_install.sh --link
```

## Layout

```
.zshrc / .bashrc             interactive shells, both load ~/.config/shell/*
.profile / .bash_profile     login shells (env only, then .bashrc)
.config/shell/env.sh         PATH and exports (POSIX sh, every entry guarded)
.config/shell/aliases.sh     aliases shared by zsh and bash
.config/shell/os/*.sh        darwin.sh / linux.sh, picked with uname
.config/shell/local.sh       per machine, untracked (see local.sh.example)
.config/bash/inputrc         bash completion and keys, close to the zsh setup
.config/tmux/tmux.conf       also linked as ~/.tmux.conf for tmux < 3.1
```

Secrets go in `~/.config/keys.sh` (untracked). When an installer appends lines to
`.bashrc`/`.zshrc`/`.profile`, `git status` in `~/dotfiles` shows it: move them to
`env.sh` or `local.sh`.

## Other branches

`macos`, `gentoo`, `manjaro` and `wsl` are older per-OS branches, kept for reference.

## TODOs
- [x] one branch with OS detection (macOS, Ubuntu)
- [x] installer for packages and plugins
- [x] symlinks instead of `~` as the repo
- [ ] WSL support (`.config/wsl/` has the configs, not wired into the installers yet)
- [ ] other distros (pacman, emerge)

## Note
If old api keys appear in git history, they have been replaced since then.
