# --- Time ---
time_str=$(date +"%H:%M:%S  %d %b %Y")

# --- Battery ---
bat_path="/sys/class/power_supply/BAT0"
if [ -d "$bat_path" ]; then
    bat_capacity=$(cat "$bat_path/capacity")
    bat_status=$(cat "$bat_path/status")
    battery_str="Battery: $bat_capacity% ($bat_status)"
else
    battery_str="Battery: N/A"
fi

# --- Volume ---
if command -v pamixer &>/dev/null; then
    vol=$(pamixer --get-volume)
    mute=$(pamixer --get-mute)
    [ "$mute" = "true" ] && vol_str="Volume: Muted" || vol_str="Volume: ${vol}%"
else
    vol_str="Volume: N/A"
fi

# --- Media ---
if command -v playerctl &>/dev/null; then
    media_info=$(playerctl metadata --format "{{ title }} – {{ artist }}" 2>/dev/null)
    [ -z "$media_info" ] && media_info="No music playing"
else
    media_info="Media: N/A"
fi

# --- Rofi Display ---
echo -e "Time: $time_str\n$battery_str\n$vol_str\nNow Playing: $media_info" | \
    rofi -dmenu -p "System Info" -theme-str 'window {width: 30%;}'

