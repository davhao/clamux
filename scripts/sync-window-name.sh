#!/bin/bash
# Recalculate window names from pane-to-name mapping
# Syncs all windows that have tracked panes, not just one
[ -d /tmp/clamux-pane-names ] || exit 0

for win_id in $(tmux list-windows -a -F '#{window_id}'); do
  names=()
  for pane_id in $(tmux list-panes -t "$win_id" -F '#{pane_id}' 2>/dev/null); do
    id="${pane_id#%}"
    if [ -f "/tmp/clamux-pane-names/$id" ]; then
      name=$(cat "/tmp/clamux-pane-names/$id")
      [ -n "$name" ] && names+=("$name")
    fi
  done

  [ ${#names[@]} -gt 0 ] || continue

  title="${names[0]}"
  for ((i=1; i<${#names[@]}; i++)); do
    title="$title | ${names[$i]}"
  done
  title="${title:0:60}"

  current=$(tmux display-message -t "$win_id" -p '#{window_name}' 2>/dev/null)
  [ "$current" = "$title" ] && continue

  tmux set-window-option -t "$win_id" automatic-rename off 2>/dev/null
  tmux set-window-option -t "$win_id" allow-rename off 2>/dev/null
  tmux rename-window -t "$win_id" "$title"
done
