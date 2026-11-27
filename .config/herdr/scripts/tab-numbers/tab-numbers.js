#!/usr/bin/env node
// Herdr plugin hook: keeps tab labels prefixed with their position ("1-name", "2-name", ...).
// Runs once per tab event (created, closed, moved, renamed). Only renames tabs whose
// label is wrong, so the tab.renamed events it triggers end in a no-op run.

const { execFileSync } = require('child_process');

const HERDR = process.env.HERDR_BIN_PATH || 'herdr';
// One or two digits followed by "-" or end of label: "3-clean repo", "12-x", "4".
const PREFIX = /^\d{1,2}(?:-|$)/;

function herdr(args) {
  return JSON.parse(execFileSync(HERDR, args, { windowsHide: true, timeout: 5000 }));
}

function desiredLabel(label, position) {
  const base = (label || '').replace(PREFIX, '');
  return base ? `${position}-${base}` : String(position);
}

const positions = new Map();
for (const tab of herdr(['tab', 'list']).result.tabs) {
  const position = (positions.get(tab.workspace_id) || 0) + 1;
  positions.set(tab.workspace_id, position);
  const wanted = desiredLabel(tab.label, position);
  if (tab.label !== wanted) herdr(['tab', 'rename', tab.tab_id, wanted]);
}
