#!/bin/bash

# DO NOT forget to put a copy of this script in the /usr/bin/
# Otherwise it will NOT work!!!

WLPDIR2="$HOME/Mega/wallpapers/vertical/"
WLPDIR1="$HOME/Mega/wallpapers/horizontal/"


files1=($WLPDIR1*)
files2=($WLPDIR2*)

wlpfile1=${files1[RANDOM % ${#files1[@]}]}
wlpfile2=${files2[RANDOM % ${#files2[@]}]}
#printf "Setting wallpaper to %s\n" "$wlpfile1"
feh --bg-fill "$wlpfile1"  --bg-fill "$wlpfile2"

