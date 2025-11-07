#!/bin/bash

# This script checks for pacman updates using the 'checkupdates' command.
# 'checkupdates' safely syncs package databases to a temporary location
# and compares them with installed packages without modifying the system database.
# This means it always shows current available updates without requiring root permissions.

# Icon for the module
ICON="󰏔"

# Run checkupdates and capture output and exit code
# checkupdates exit codes:
#   0 = updates available
#   1 = error occurred
#   2 = no updates available
updates=$(checkupdates 2> /dev/null)
exit_code=$?

# Check for errors (exit code 1)
if [ $exit_code -eq 1 ]; then
    printf '{"text": "%s ?", "tooltip": "Error checking for updates. (checkupdates failed)"}\n' "$ICON"
    exit 0
fi

# Handle cases where there are no updates (exit code 2) or updates available (exit code 0)
if [ $exit_code -eq 2 ]; then # No updates
    printf '{"text": "%s 0", "tooltip": "No new updates"}\n' "$ICON"
else # Updates available (exit_code is 0)
    # Count the number of updates
    update_count=$(echo "$updates" | wc -l)

    # Generate the tooltip
    if [ "$update_count" -gt 5 ]; then
        tooltip=$(echo "$updates" | head -n 5)
        tooltip+=$'\n...'
    else
        tooltip=$updates
    fi

    # Escape special characters for JSON
    tooltip=$(echo "$tooltip" | sed 's/"/\\"/g' | sed ':a;N;$!ba;s/\n/\\n/g')

    # Output JSON
    printf '{"text": "%s %s", "tooltip": "%s"}\n' "$ICON" "$update_count" "$tooltip"
fi

# Trigger waybar module refresh
pkill -RTMIN+9 waybar

