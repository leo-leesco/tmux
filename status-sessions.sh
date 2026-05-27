#!/bin/sh
# Build status-left: numbered list of sessions, with the attached one
# expanded to show its windows. Sessions sorted alphabetically by name.
#
# Uses a NUL-separated stream and a single awk pass so session names
# containing shell metacharacters (>, |, &, spaces, ...) render correctly.

{
    tmux list-sessions -F 'S#{session_name}#{?session_attached,	1,	0}'
    tmux list-windows -a -F 'W#{session_name}	#{window_index}:#{window_name}#{window_flags}'
} | awk -F'\t' '
    /^S/ {
        name = substr($1, 2)
        sessions[++n] = name
        attached[name] = $2
        next
    }
    /^W/ {
        name = substr($1, 2)
        wins[name] = wins[name] " " $2
    }
    END {
        # sort session names alphabetically
        for (i = 1; i <= n; i++)
            for (j = i + 1; j <= n; j++)
                if (sessions[i] > sessions[j]) {
                    t = sessions[i]; sessions[i] = sessions[j]; sessions[j] = t
                }
        for (i = 1; i <= n; i++) {
            s = sessions[i]
            if (attached[s] == "1")
                printf "#[fg=black,bg=brightcyan,bold][%s >%s]#[default] ", s, wins[s]
            else
                printf "%d:%s ", i, s
        }
    }
'
