#!/bin/sh
# Switch to the Nth session in the alphabetical session list (1-indexed).
n="$1"
target=$(tmux list-sessions -F '#{session_name}' | sort | sed -n "${n}p")
[ -n "$target" ] && tmux switch-client -t "$target"
