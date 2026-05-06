#!/bin/sh
tmux list-sessions -F '#{session_name}|#{?session_attached,1,0}' | sort | awk -F'|' '{
    if ($2 == "1") {
        cmd = "tmux list-windows -t " $1 " -F \"#{window_index}:#{window_name}#{window_flags}\""
        wins = ""
        while ((cmd | getline w) > 0) wins = wins " " w
        close(cmd)
        printf "#[fg=black,bg=brightcyan,bold][%s >%s]#[default] ", $1, wins
    } else {
        printf "%s ", $1
    }
}'
