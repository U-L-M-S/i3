#!/bin/bash

# Include API KEY (safe way)
api_keys_file="/home/silcniu/Mega/api_keys.json"
wallhaven_key=$(jq -r '.wallhaven' "$api_keys_file")

content='anime'
counter_file="/home/silcniu/.local/bin/scripts/counter.txt"
horizontal_wallpapers_path="/home/silcniu/Mega/wallpapers/horizontal/"
vertical_wallpapers_path="/home/silcniu/Mega/wallpapers/vertical/"

if [ ! -f "$counter_file" ]; then
  # Create the counter.txt file with initial counter value
  echo "counter: 1" > "$counter_file"
fi

dunstify "󰋹  Starting the script ..."

counter=$(grep -oP '(?<=counter: ).*' "$counter_file")
page=$counter

while [ "$page" -le "$((counter + 5))" ]
do
  curl -s "https://wallhaven.cc/api/v1/search?categories=111&purity=110&sorting=views&order=asc&topRange=1y&resolutions=1920x1080&ratios=16x9&colors=000000&page=$page" | jq -r '.data[].path' | while read -r wallpaper_path; do
    filename=$(basename "$wallpaper_path")
    if [ ! -f "$horizontal_wallpapers_path$filename" ]; then
      wget -P "$horizontal_wallpapers_path" "$wallpaper_path"
    fi
  done
  
  curl -s "https://wallhaven.cc/api/v1/search?categories=111&purity=110&sorting=views&order=asc&topRange=1y&resolutions=1920x1080&ratios=9x16&colors=000000&page=$page" | jq -r '.data[].path' | while read -r wallpaper_path; do
    filename=$(basename "$wallpaper_path")
    if [ ! -f "$vertical_wallpapers_path$filename" ]; then
      wget -P "$vertical_wallpapers_path" "$wallpaper_path"
    fi
  done

  page=$((page + 1))
done

new_counter=$((counter + 5))
sed -i "s/counter: $counter/counter: $new_counter/" "$counter_file"

dunstify "󰋹      _           $new_counter"

