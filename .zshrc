## Kevin's config for the zoomer shell (macOS + Linux)

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Keep $PATH duplicate-free across nested shells.
typeset -U path PATH

# Enable colors and change prompt:
autoload -U colors && colors

## Options section
setopt correct                                                  # Auto correct mistakes
setopt extendedglob                                             # Extended globbing. Allows using regular expressions with *
setopt nocaseglob                                               # Case insensitive globbing
setopt rcexpandparam                                            # Array expension with parameters
setopt nocheckjobs                                              # Don't warn about running processes when exiting
setopt numericglobsort                                          # Sort filenames numerically when it makes sense
setopt nobeep                                                   # No beep
setopt appendhistory                                            # Immediately append history instead of overwriting
setopt histignorealldups                                        # If a new command is a duplicate, remove the older one
setopt autocd                                                   # if only directory path is entered, cd there.
setopt inc_append_history                                       # save commands are added to the history immediately, otherwise only when shell exits.
setopt histignorespace                                          # Don't save commands that start with space

zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' # Case insensitive tab completion
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"         # Colored completion (different colors for dirs/files/etc)
zstyle ':completion:*' rehash true                              # automatically find new executables in path
zstyle ':completion:*' menu select                              # Highlight menu selection
# Speed up completions
zstyle ':completion:*' accept-exact '*(N)'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache
HISTFILE=~/.zhistory
HISTSIZE=10000
SAVEHIST=10000
WORDCHARS=${WORDCHARS//\/[&.;]}                                 # Don't consider certain characters part of the word

## Keybindings section
bindkey -e
bindkey '^[[7~' beginning-of-line                               # Home key
bindkey '^[[H' beginning-of-line                                # Home key
if [[ "${terminfo[khome]}" != "" ]]; then
  bindkey "${terminfo[khome]}" beginning-of-line                # [Home] - Go to beginning of line
fi
bindkey '^[[8~' end-of-line                                     # End key
bindkey '^[[F' end-of-line                                      # End key
if [[ "${terminfo[kend]}" != "" ]]; then
  bindkey "${terminfo[kend]}" end-of-line                       # [End] - Go to end of line
fi
bindkey '^[[2~' overwrite-mode                                  # Insert key
bindkey '^[[3~' delete-char                                     # Delete key
bindkey '^[[C'  forward-char                                    # Right key
bindkey '^[[D'  backward-char                                   # Left key
bindkey '^[[5~' history-beginning-search-backward               # Page up key
bindkey '^[[6~' history-beginning-search-forward                # Page down key

# Navigate words with ctrl+arrow keys
bindkey '^[Oc' forward-word                                     #
bindkey '^[Od' backward-word                                    #
bindkey '^[[1;5D' backward-word                                 #
bindkey '^[[1;5C' forward-word                                  #
bindkey '^H' backward-kill-word                                 # delete previous word with ctrl+backspace
bindkey '^[[Z' undo                                             # Shift+tab undo last action

# Theming section
autoload -U compinit colors zcalc
compinit -d
colors



### SHELL CONFIG (shared with bash)
[ -f "$HOME/.config/shell/env.sh" ] && source "$HOME/.config/shell/env.sh"
[ -f "$HOME/.config/shell/aliases.sh" ] && source "$HOME/.config/shell/aliases.sh"
case "$(uname -s)" in
  Darwin) _os=darwin ;;
  *) _os=linux ;;
esac
[ -f "$HOME/.config/shell/os/$_os.sh" ] && source "$HOME/.config/shell/os/$_os.sh"
unset _os
[ -f "$HOME/.config/zsh/scripts.zsh" ] && source "$HOME/.config/zsh/scripts.zsh"
[ -f "$HOME/.config/shell/local.sh" ] && source "$HOME/.config/shell/local.sh"
[ -r "$HOME/.config/keys.sh" ] && source "$HOME/.config/keys.sh"
alias reload='source ~/.zshrc'



### TOOLS (only if installed)

# nvm
[ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && source "$NVM_DIR/bash_completion"

# Pyenv
command -v pyenv >/dev/null && eval "$(pyenv init - zsh)"

# Pixi
command -v pixi >/dev/null && eval "$(pixi completion --shell zsh)"

# Conda / mamba (miniforge3 or mambaforge)
for _c in "$HOME/miniforge3" "$HOME/mambaforge"; do
  if [ -x "$_c/bin/conda" ]; then
    eval "$("$_c/bin/conda" shell.zsh hook 2>/dev/null)"
    [ -f "$_c/etc/profile.d/mamba.sh" ] && source "$_c/etc/profile.d/mamba.sh"
    break
  fi
done
unset _c



### PLUGINS (installed by ~/dotfiles/install.sh)
_zp="$HOME/.zsh"

# Load history substring search, bind UP and DOWN arrow keys
if [ -f "$_zp/zsh-history-substring-search/zsh-history-substring-search.zsh" ]; then
  source "$_zp/zsh-history-substring-search/zsh-history-substring-search.zsh"
  zmodload zsh/terminfo
  bindkey "$terminfo[kcuu1]" history-substring-search-up
  bindkey "$terminfo[kcud1]" history-substring-search-down
  bindkey '^[[A' history-substring-search-up
  bindkey '^[[B' history-substring-search-down
else
  bindkey '^[[A' history-beginning-search-backward
  bindkey '^[[B' history-beginning-search-forward
fi

# Load autosuggestions
[ -f "$_zp/zsh-autosuggestions/zsh-autosuggestions.zsh" ] && source "$_zp/zsh-autosuggestions/zsh-autosuggestions.zsh"

# Load sudo: adds sudo after hitting escape twice
[ -f "$_zp/zsh-sudo/sudo.plugin.zsh" ] && source "$_zp/zsh-sudo/sudo.plugin.zsh"

# Load zsh-z: jump around directories with z
[ -f "$_zp/zsh-z/zsh-z.plugin.zsh" ] && source "$_zp/zsh-z/zsh-z.plugin.zsh"

# Load zsh-syntax-highlighting; should be last of the plugins.
[ -f "$_zp/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ] && source "$_zp/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
unset _zp

# p10k stuff
[ -f ~/powerlevel10k/powerlevel10k.zsh-theme ] && source ~/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
