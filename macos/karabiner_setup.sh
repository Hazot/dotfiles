#!/usr/bin/env bash
# Add the Caps Lock navigation layer to the selected Karabiner-Elements profile (macOS only).
# Run by hand: bash ~/dotfiles/macos/karabiner_setup.sh   (again after editing nav-layer.json)
# Rule: .config/karabiner/assets/complex_modifications/nav-layer.json (same layer as linux/keyd.conf)
# Replaces a previous copy of the rule, other rules and profiles are kept.
set -euo pipefail

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
RULE="$DOTFILES/.config/karabiner/assets/complex_modifications/nav-layer.json"
CONF="${KARABINER_CONF:-$HOME/.config/karabiner/karabiner.json}"

[[ -f "$CONF" ]] || { echo "$CONF not found: install and open Karabiner-Elements once first" >&2; exit 1; }

cp "$CONF" "$CONF.bak"
python3 - "$RULE" "$CONF" <<'PY'
import json, sys
rule_path, conf_path = sys.argv[1], sys.argv[2]
new_rules = json.load(open(rule_path))["rules"]
conf = json.load(open(conf_path))
profiles = conf.get("profiles", [])
profile = next((p for p in profiles if p.get("selected")), profiles[0] if profiles else None)
if profile is None:
    sys.exit("no Karabiner profile found")
cm = profile.setdefault("complex_modifications", {})
# Earlier versions of this rule all start with "Tap Caps = Esc"
rules = [r for r in cm.get("rules", []) if not r.get("description", "").startswith("Tap Caps = Esc")]
cm["rules"] = new_rules + rules
json.dump(conf, open(conf_path, "w"), indent=4)
print(f"Caps Lock layer added to profile \"{profile.get('name', '?')}\"")
PY
echo "Backup: $CONF.bak"
