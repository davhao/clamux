#!/bin/bash
# Register tmux hooks for name persistence after join/break (idempotent)
[ -n "$TMUX" ] || exit 0
mkdir -p /tmp/clamux-pane-names
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
SYNC="$SCRIPT_DIR/sync-window-name.sh"
# after-select-pane: fires after join-pane changes pane focus
# window-linked: fires after break-pane creates a new window
tmux set-hook -g after-select-pane "run-shell -b \"$SYNC\""
tmux set-hook -g window-linked "run-shell -b \"$SYNC\""
