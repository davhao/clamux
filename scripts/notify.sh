#!/bin/bash
# Send macOS notification when Claude needs attention in an inactive tmux window
[ -n "$TMUX_PANE" ] || exit 0
is_active=$(tmux display-message -t "$TMUX_PANE" -p '#{window_active}' 2>/dev/null)
[ "$is_active" = "0" ] || exit 0
wname=$(tmux display-message -t "$TMUX_PANE" -p '#{window_name}' 2>/dev/null)
msg=$(jq -r '.message')
osascript -e "display notification \"$msg\" with title \"$wname\""
