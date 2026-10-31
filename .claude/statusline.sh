#!/bin/sh
# Claude Code status line: model | dir (branch) | context usage
input=$(cat)

model=$(printf '%s' "$input" | jq -r '.model.display_name // .model.id // "?"')
dir=$(printf '%s' "$input" | jq -r '.workspace.current_dir // .cwd // empty')
pct=$(printf '%s' "$input" | jq -r '.context_window.used_percentage // empty | floor')
used=$(printf '%s' "$input" | jq -r '.context_window.total_input_tokens // empty')
size=$(printf '%s' "$input" | jq -r '.context_window.context_window_size // empty')

branch=""
if [ -n "$dir" ]; then
  branch=$(git -C "$dir" --no-optional-locks branch --show-current 2>/dev/null)
fi

line="$model | ${dir##*/}"
[ -n "$branch" ] && line="$line ($branch)"

if [ -n "$pct" ]; then
  ctx="ctx ${pct}%"
  if [ -n "$used" ] && [ -n "$size" ]; then
    ctx="$ctx ($((used / 1000))k/$((size / 1000))k)"
  fi
  line="$line | $ctx"
fi

printf '%s' "$line"
