#!/bin/sh
# Switch to the previous (-1) or next (+1) session in alphabetical order,
# wrapping around at the ends. Mirrors the numbering shown in status-left.
direction="$1"
current=$(tmux display-message -p '#{session_name}')
sessions=$(tmux list-sessions -F '#{session_name}' | sort)

idx=$(printf '%s\n' "$sessions" | grep -nxF -- "$current" | cut -d: -f1)
total=$(printf '%s\n' "$sessions" | wc -l | tr -d ' ')
[ -z "$idx" ] || [ "$total" -le 1 ] && exit 0

case "$direction" in
  -1) target_idx=$(( (idx - 2 + total) % total + 1 )) ;;
  +1|1) target_idx=$(( idx % total + 1 )) ;;
  *) exit 1 ;;
esac

target=$(printf '%s\n' "$sessions" | sed -n "${target_idx}p")
[ -n "$target" ] && tmux switch-client -t "$target"
