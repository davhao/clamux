#!/bin/bash
# Auto-rename tmux window based on conversation topic (runs once per pane)
[ -n "$TMUX_PANE" ] || exit 0
[ ! -f "/tmp/claude-tmux-title-${TMUX_PANE}" ] || exit 0
touch "/tmp/claude-tmux-title-${TMUX_PANE}"
win=$(tmux display-message -t "$TMUX_PANE" -p '#{window_id}' 2>/dev/null) || exit 0
msg=$(jq -r '.prompt')
title=$(cd /tmp && printf 'Generate a short 2-4 word title for the following chat message. Output ONLY the title, nothing else.\n\n%s' "$msg" | claude --print --model haiku 2>/dev/null | tr -d '"' | head -1 | cut -c1-30)
[ -n "$title" ] && tmux set-window-option -t "$win" automatic-rename off && tmux set-window-option -t "$win" allow-rename off && tmux rename-window -t "$win" "$title" || true
