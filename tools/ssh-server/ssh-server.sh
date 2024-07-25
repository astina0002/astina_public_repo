#!/bin/bash

# Arrays to store server aliases and commands
server_aliases=()
commands=()

# Read server_commands.txt file
while IFS=$'\t' read -r alias command; do
  server_aliases+=("$alias")
  commands+=("$command")
done < /Users/username/.ssh_server/server_commands.txt

# Clear the screen
clear

# Use fzf to select a server
selected=$(for i in "${!server_aliases[@]}"; do
  echo "$i. ${server_aliases[$i]}"
done | fzf --prompt="Select a server to connect to: " --height=30 --reverse --ansi)

# Extract the index of the selected server
if [ -n "$selected" ]; then
  selected_index=$(echo "$selected" | cut -d. -f1)
  selected_alias="${server_aliases[$selected_index]}"
  selected_command="${commands[$selected_index]}"
  echo "Connecting to $selected_alias server by executing '$selected_command' command..."
  eval "$selected_command"
else
  echo "Cancelled."
fi

