#!/bin/bash

while true; do
  
  # Directory path for wallpapers
  wallpapers_dir=~/Mega/wallpapers/horizontal/

  # Get a random image from the directory
  random_image=$(find "$wallpapers_dir" -type f -name '*.jpg' -o -name '*.png' | shuf -n 1)

  # Set the random image as the Betterlockscreen wallpaper
  betterlockscreen -u "$random_image" --fx blur

  # 5 mins
  sleep 300

done

