# clamux

A [Claude Code](https://claude.ai/claude-code) plugin for tmux users.

- **Notifications** — sends macOS notifications when Claude needs attention and your tmux window isn't active
- **Auto-rename** — renames your tmux window based on the conversation topic

## Install

1. Open Claude Code
2. Run `/plugin` → Add marketplace → GitHub → `davhao/clamux`
3. Enable the `clamux` plugin

## Requirements

- macOS (uses `osascript` for notifications)
- tmux
- `jq`
