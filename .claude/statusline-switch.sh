#!/bin/sh
# Status line switcher
# touch ~/.claude/use-ccstatusline to use ccstatusline, rm it to go back to statusline.sh
if [ -f "$HOME/.claude/use-ccstatusline" ]; then
  # Pinned version: bump after checking the release notes
  exec npx -y ccstatusline@2.2.32
fi
exec sh "$HOME/.claude/statusline.sh"
