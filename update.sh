#!/usr/bin/env bash
# Pull the dotfiles and independent config repos, only when it's safe:
# repo exists, working tree is clean and on main. Never touches feature branches.
set -uo pipefail

REPOS=(
    "$HOME/dotfiles"
    "$HOME/.config/nvim"
    "$HOME/.config/sioyek"
)

for repo in "${REPOS[@]}"; do
    name=${repo/#$HOME/\~}
    if [[ ! -d "$repo/.git" ]]; then
        echo "skip $name: not a git repo"
        continue
    fi
    branch=$(git -C "$repo" symbolic-ref --short HEAD 2>/dev/null)
    if [[ "$branch" != main ]]; then
        echo "skip $name: on ${branch:-detached HEAD}, not main"
        continue
    fi
    if [[ -n "$(git -C "$repo" status --porcelain)" ]]; then
        echo "skip $name: uncommitted changes"
        continue
    fi
    printf 'pull %s: ' "$name"
    git -C "$repo" pull --ff-only --quiet && echo ok || echo "failed (diverged?)"
done
