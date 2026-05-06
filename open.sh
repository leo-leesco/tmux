#!/bin/sh
target=$(cat)
if echo "$target" | grep -qE '^https?://'; then
    open "$target"
else
    tmux split-window "nvim $target"
fi
