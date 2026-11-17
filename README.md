# dotfiles

My shell, tmux, vim and git configuration, one `main` branch for macOS and Ubuntu.
The repo lives in `~/dotfiles` and its files are symlinked into `~`.

Neovim and Sioyek configs are independent repos, cloned by the installer:

| Repo | Location |
|---|---|
| [Hazot/dotfiles](https://github.com/Hazot/dotfiles) | `~/dotfiles` |
| [Hazot/nvim](https://github.com/Hazot/nvim) | `~/.config/nvim` |
| [Hazot/sioyek](https://github.com/Hazot/sioyek) | `~/.config/sioyek` |

## Prerequisites

The kitty config uses CaskaydiaCove Nerd Font Mono. It is not installed by `install.sh`,
and is only needed on machines with a graphical terminal.

```sh
# macOS
brew install --cask font-caskaydia-cove-nerd-font

# Ubuntu
mkdir -p ~/.local/share/fonts/CaskaydiaCove
curl -fsSL -o /tmp/CascadiaCode.zip https://github.com/ryanoasis/nerd-fonts/releases/latest/download/CascadiaCode.zip
unzip -o /tmp/CascadiaCode.zip -d ~/.local/share/fonts/CaskaydiaCove
fc-cache -f
```

## Full machine (macOS, Ubuntu)

```sh
git clone git@github.com:Hazot/dotfiles.git ~/dotfiles
~/dotfiles/install.sh        # asks y/n for each group, -y for all
```

It links every file into `~` (existing files go to `~/.dotfiles-backup/<date>/`), then offers:
core packages, zsh plugins + powerlevel10k, tpm, Neovim (+ ripgrep, fd, node, `Hazot/nvim`),
`Hazot/sioyek`, dev extras (rustup, uv, pixi, pipx), zsh as default shell.
Repos are only cloned when missing, never pulled or overwritten.

Pull the latest config later, from this repo, `Hazot/nvim` and `Hazot/sioyek`:

```sh
~/dotfiles/update.sh         # or: dfu
```

A repo is skipped when it has uncommitted changes or is not on `main`, and a pull that
would need a merge is left alone. Files the pull added are then linked into `~`
(`install.sh --link`). Packages, plugins and the GNOME scripts are not updated.

## Manual steps after install

These are not done by `install.sh`.

### Claude Code status line

`.claude/settings.json` points the status line at `.claude/statusline-switch.sh`, which runs
either ccstatusline or the plain `.claude/statusline.sh`. Pick one per machine:

```sh
sl-cc      # ccstatusline (needs node/npx, config in .config/ccstatusline/settings.json)
sl-mine    # plain statusline.sh (needs jq)
```

The choice is the untracked file `~/.claude/use-ccstatusline`, so new machines start on `sl-mine`.
It shows up in the next Claude session.

### GNOME (Ubuntu)

GNOME settings live in dconf, not in files, so they can't be symlinked. Run the scripts once
per machine, and again after changing them:

```sh
bash ~/dotfiles/linux/gnome_settings.sh   # mouse, touchpad, GPaste history
bash ~/dotfiles/linux/gnome_keybinds.sh   # workspaces, tiling, monitors, screenshot, Super+N/V/E
```

`gnome_keybinds.sh` sets the tiling keys on the Tiling Assistant extension when it is enabled,
otherwise on GNOME itself. Keep the extension disabled to use GNOME's tiling.

### Caps Lock navigation layer

Tap Caps for Esc. Hold Caps with `h`/`j`/`k`/`l` for arrows, `u`/`d` for Page Up/Down,
and `a`/`e` (or vim-like `0`/`4`) for Home/End. Same layer on both OSes:

```sh
# Ubuntu: installs keyd, copies linux/keyd.conf to /etc/keyd/ (needs sudo)
bash ~/dotfiles/linux/keyd_setup.sh
```

```sh
# macOS: adds the rule to the selected Karabiner-Elements profile, keeps everything else
brew install --cask karabiner-elements   # open it once and allow its permissions
bash ~/dotfiles/macos/karabiner_setup.sh
```

The rule lives in `.config/karabiner/assets/complex_modifications/nav-layer.json`. It also
shows up in Karabiner under Complex Modifications > Add predefined rule.

`install.sh` links the whole `~/.config/karabiner` folder, and the tracked `karabiner.json`
already has the layer enabled: the script is only needed after editing `nav-layer.json`.
Caps Lock is not remapped to Ctrl in `simple_modifications`, since Karabiner applies those
before complex rules and the layer would never see Caps.

### VS Code (Ubuntu)

Install the `.deb`, not the snap from App Center: the snap is sandboxed, which causes
problems with the integrated terminal, shells and tools from `~`, and input methods.
The `.deb` also adds Microsoft's apt repo, so `apt upgrade` keeps it updated.

```sh
sudo snap remove code   # only if the snap is installed
curl -fsSL -o /tmp/code.deb 'https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64'
sudo apt install /tmp/code.deb
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
.config/kitty/kitty.conf     only the settings that differ from kitty's defaults
.config/herdr/config.toml    herdr, keybinds mirror tmux.conf
.config/karabiner/           macOS only, the whole folder is linked (Karabiner rewrites the file)
.claude/settings.json        Claude Code: status line, env (scroll speed, telemetry off)
linux/gnome_*.sh             GNOME settings and keybinds, run by hand (see above)
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
