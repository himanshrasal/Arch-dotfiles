#!/bin/bash

# Add pipx wal to PATH
export PATH="$HOME/.local/bin:$PATH"

WALLPAPER_DIR="$(dirname "$0")"
INTERVAL=60 # 1 minute

# Start swww-daemon if not running
pgrep -x swww-daemon >/dev/null || swww-daemon &
sleep 1  # give swww time to start

while true; do
  mapfile -t images < <(find "$WALLPAPER_DIR" -type f \( -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.png' \) | shuf)
  for img in "${images[@]}"; do
    swww img "$img" --transition-type any --transition-duration 1.5
    sleep 1
    wal -q -n -i "$img" --backend haishoku
    sleep "$INTERVAL"
  done
done

