## Kevin's config for bash (portable: macOS, Linux, VMs, no plugins)

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

## Options
shopt -s autocd 2>/dev/null # cd into typed directory (bash 4+)
shopt -s cdspell        # fix small typos in cd
shopt -s dirspell 2>/dev/null # bash 4+
shopt -s nocaseglob     # case insensitive globbing
shopt -s globstar 2>/dev/null # ** matches subdirectories (bash 4+)
shopt -s extglob        # extended globbing
shopt -s checkwinsize   # update LINES and COLUMNS after each command
shopt -s no_empty_cmd_completion
set +o notify           # don't report background jobs immediately

## History
HISTFILE=~/.bash_history
HISTSIZE=10000
HISTFILESIZE=10000
HISTCONTROL=ignoreboth:erasedups # skip dups and lines starting with space
HISTIGNORE='ls:ll:la:l:cd:pwd:exit:clear'
shopt -s histappend     # append to the history file, don't overwrite it
shopt -s cmdhist        # multi-line commands as one entry

## Readline (completion, keys)
[ -f "$HOME/.config/bash/inputrc" ] && export INPUTRC="$HOME/.config/bash/inputrc"

## Completion
if ! shopt -oq posix; then
    for _f in /usr/share/bash-completion/bash_completion /etc/bash_completion \
              "${HOMEBREW_PREFIX:-/opt/homebrew}/etc/profile.d/bash_completion.sh"; do
        if [ -r "$_f" ]; then . "$_f"; break; fi
    done
    unset _f
fi

## Environment, aliases, OS specifics, machine specifics
[ -f "$HOME/.config/shell/env.sh" ] && . "$HOME/.config/shell/env.sh"
[ -f "$HOME/.config/shell/aliases.sh" ] && . "$HOME/.config/shell/aliases.sh"
case "$(uname -s)" in
    Darwin) _os=darwin ;;
    *) _os=linux ;;
esac
[ -f "$HOME/.config/shell/os/$_os.sh" ] && . "$HOME/.config/shell/os/$_os.sh"
unset _os
[ -f "$HOME/.config/shell/local.sh" ] && . "$HOME/.config/shell/local.sh"
[ -r "$HOME/.config/keys.sh" ] && . "$HOME/.config/keys.sh"
alias reload='source ~/.bashrc'

## Tools (only if installed)
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"
command -v pyenv >/dev/null 2>&1 && eval "$(pyenv init - bash)"
command -v pixi >/dev/null 2>&1 && eval "$(pixi completion --shell bash)"
for _c in "$HOME/miniforge3" "$HOME/mambaforge"; do
    if [ -x "$_c/bin/conda" ]; then
        eval "$("$_c/bin/conda" shell.bash hook 2>/dev/null)"
        [ -f "$_c/etc/profile.d/mamba.sh" ] && . "$_c/etc/profile.d/mamba.sh"
        break
    fi
done
unset _c

## z: jump to the most visited directory matching all args (z foo bar)
_Z_DATA="${XDG_DATA_HOME:-$HOME/.local/share}/z"
_z_add() {
    [ "$PWD" = "$HOME" ] && return
    [ "$PWD" = "$_Z_LAST" ] && return
    _Z_LAST=$PWD
    command mkdir -p "${_Z_DATA%/*}"
    {
        printf '%s\n' "$PWD"
        if [ -f "$_Z_DATA" ]; then head -n 2000 "$_Z_DATA"; fi
    } > "$_Z_DATA.tmp" && command mv -f "$_Z_DATA.tmp" "$_Z_DATA"
}
z() {
    [ $# -eq 0 ] && { cd ~ || return; return; }
    [ -f "$_Z_DATA" ] || return 1
    local dir
    dir=$(awk -v q="$*" '
        BEGIN { n = split(tolower(q), w, " ") }
        { l = tolower($0); ok = 1
          for (i = 1; i <= n; i++) if (index(l, w[i]) == 0) ok = 0
          if (ok) c[$0]++ }
        END { for (d in c) if (c[d] > best) { best = c[d]; r = d }; print r }
    ' "$_Z_DATA")
    [ -n "$dir" ] && [ -d "$dir" ] && cd "$dir" || { echo "z: no match for '$*'" >&2; return 1; }
}

## Prompt: user@host dir (branch) $
_git_branch() {
    local b
    b=$(git symbolic-ref --short HEAD 2>/dev/null || git rev-parse --short HEAD 2>/dev/null) || return
    printf ' (%s)' "$b"
}
_prompt() {
    local status=$?
    history -a  # write each command right away (like zsh inc_append_history)
    _z_add
    local red='\[\e[01;31m\]' green='\[\e[01;32m\]' blue='\[\e[01;34m\]' yellow='\[\e[33m\]' reset='\[\e[00m\]'
    local sym='\$'
    [ $status -ne 0 ] && sym="$red\$$reset"
    PS1="\[\e]0;\u@\h: \w\a\]$green\u@\h$reset $blue\w$reset$yellow$(_git_branch)$reset $sym "
}
PROMPT_COMMAND=_prompt
