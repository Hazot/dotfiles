#!/bin/sh
# Status line switcher
# touch ~/.claude/use-ccstatusline to use ccstatusline, rm it to go back to statusline.sh
if [ -f "$HOME/.claude/use-ccstatusline" ]; then
  exec npx -y ccstatusline@latest
fi
exec sh "$HOME/.claude/statusline.sh"
