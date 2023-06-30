# Autostart applications
# /usr/lib/x86_64-linux-gnu/polkit-mate/polkit-mate-authentication-agent-1 &
/usr/lib/policykit-1-gnome/polkit-gnome-authentication-agent-1 &
# nitrogen --restore; sleep 1; 
# feh --bg-fill ~/.config/backgrounds/wallhaven-y8o51x_1920x1080.png &
bash ~/.local/bin/scripts/change_bk.sh &
numlockx on &
nm-applet &
# volumeicon &
dunst &
xrandr --output DVI-D-0 --off --output HDMI-0 --mode 1920x1080 --pos 0x0 --rotate left --output DP-0 --mode 1920x1080 --pos 1080x840 --rotate normal --output DP-1 --off
xrandr --dpi 114
# blueman-applet &
# Set/Change current lockscreen
exec ~/.local/bin/scripts/set_BK_betterlockscreen.sh &
mega-sync &
# exec ~/.local/bin/scripts/config_workflow.sh &
exec ~/.local/bin/scripts/download_wallpapers.sh &

### Do not turn off the screen ###
xset s off &
xset -dpms &

### Set composer ###
if ps -C picom; then
  killall picom
  picom -b -C -f --config ~/.config/picom/picom.conf &
else
  picom -b -C -f --config ~/.config/picom/picom.conf &
fi

# ## Restart the sctipt that changes background automatically
# if ps -C change_bk.sh; then
#   killall change_bk.sh
#   bash ~/.local/bin/scripts/change_bk.sh &
# else
#   bash ~/.local/bin/scripts/change_bk.sh &
# fi 

# sxhkd
sxhkd -c ~/.config/i3/sxhkdrc &


