# tmux cheat sheet

Prefix: `Ctrl-Space` (written `P`). Checked against `tmux.conf` and tmux 3.8.

Full list inside tmux: `P ?`

## Sessions

No default shortcut creates a session: go through the `P :` prompt.

| Action | Command |
|--------|---------|
| New session, from inside tmux | `P :` then `new -s name` |
| New session, from the shell | `tmux new -s name` |
| Create or attach to a session | `tmux new -As name` |
| Create without attaching | `tmux new -d -s name` |
| List | `tmux ls` |
| Attach | `tmux a -t name` |
| Browse sessions (tree) | `P s` |
| Previous / next session | `P (` / `P )` |
| Last session | `P L` |
| Rename | `P $` |
| Detach | `P d` |
| Kill current session | `P :` then `kill-session` |
| Kill a session by name | `tmux kill-session -t name` |
| Kill everything | `tmux kill-server` |

## Windows

| Action | Key |
|--------|-----|
| New window | `P c` |
| Next / previous | `P n` / `P p` or `P Ctrl-n` / `P Ctrl-p` |
| Cycle (repeatable) | `P Ctrl-f` / `P Ctrl-b` |
| Last window | `P Space` or `P l` |
| Go to number | `P 0` to `P 9` |
| Choose from tree | `P w` |
| Find | `P f` |
| Rename | `P ,` |
| Kill | `P &` |

## Panes

| Action | Key |
|--------|-----|
| Split side by side | `P \|` |
| Split top / bottom | `P -` |
| Move (no prefix) | `Alt-h/j/k/l` or `Alt-arrows` |
| Last pane | `P ;` |
| Zoom / unzoom | `P z` |
| Resize in steps of 5 | `P Alt-arrows` |
| Next layout | `P /` |
| Swap with previous / next | `P {` / `P }` |
| Break out to a new window | `P !` |
| Show pane numbers | `P q` |
| Kill | `P x` |

## Scrolling and copying (vi keys)

| Action | Key |
|--------|-----|
| Enter copy mode | `P [` |
| Enter copy mode, one page up | `P PageUp` |
| Start selection | `Space` |
| Copy and exit | `Enter` |
| Search down / up | `/` / `?` |
| Next / previous match | `n` / `N` |
| Exit | `q` |
| Paste | `P ]` |

Dragging with the mouse also copies the selection.

## Saving and config

| Action | Key |
|--------|-----|
| Save environment (resurrect) | `P Ctrl-s` |
| Restore environment (resurrect) | `P Ctrl-r` |
| Reload `tmux.conf` | `P R` |
| Install plugins (tpm) | `P I` |
| Update plugins (tpm) | `P U` |

continuum saves every 60 minutes, but restoring stays manual.
