#!/bin/bash
COMMAND="kak -s IDE -e 'rename-client code' $1"
SESSION_NAME="code"
if tmux has-session -t $SESSION_NAME 2>/dev/null; then
	echo "session $SESSION_NAME already exists, attaching to it instead"
	tmux attach-session -t $SESSION_NAME
else
	tmux new-session -d -s $SESSION_NAME
	tmux send-keys -t $SESSION_NAME:1 "kak -clear" C-m
	tmux send-keys -t $SESSION_NAME:1 "clear" C-m
	tmux send-keys -t $SESSION_NAME:1 "$COMMAND" C-m
	tmux split-window -h
	tmux resize-pane -R 35
	sleep 1
	tmux send-keys -t $SESSION_NAME:1 "kak -c IDE -e 'rename-client docs'" C-m
	tmux splitw -v
	tmux send-keys -t $SESSION_NAME:1 "RPROMPT='' && PROMPT='%F{14} ❱ ' && clear && exa -T" C-m
	tmux select-pane -L
	tmux attach-session -t $SESSION_NAME
fi
