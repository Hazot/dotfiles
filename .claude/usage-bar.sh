#!/bin/sh
# 5-char usage bar for ccstatusline (custom-command widget)
# Usage: usage-bar.sh session|weekly
# Reads the cache written by ccstatusline's native usage widgets
cache="$HOME/.cache/ccstatusline/usage.json"
cat > /dev/null
[ -f "$cache" ] || exit 0

pct=$(jq -r ".${1}Usage // empty" "$cache" 2>/dev/null)
[ -n "$pct" ] || exit 0

filled=$(awk -v p="$pct" 'BEGIN { n = int(p / 20 + 0.5); if (n > 5) n = 5; if (n < 0) n = 0; print n }')
bar=""
i=0
while [ $i -lt 5 ]; do
  if [ $i -lt "$filled" ]; then bar="${bar}▓"; else bar="${bar}░"; fi
  i=$((i + 1))
done
printf '%s' "$bar"
