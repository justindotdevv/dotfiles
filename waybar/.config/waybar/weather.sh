#!/bin/bash

# Waybar weather module using wttr.in
# Format: [nerd font weather icon][temperature]
# Uses caching for instant display on startup

CACHE_DIR="${XDG_CACHE_HOME:-$HOME/.cache}/waybar"
CACHE_FILE="$CACHE_DIR/weather.json"
LOCK_FILE="$CACHE_DIR/weather.lock"
mkdir -p "$CACHE_DIR"

get_weather_icon() {
    case "$1" in
        "Clear"|"Sunny")                echo "󰖙" ;;
        "PartlyCloudy"|"Partly cloudy") echo "󰖕" ;;
        "Cloudy"|"Overcast")            echo "󰖐" ;;
        "Fog"|"Mist")                   echo "󰖑" ;;
        "LightRain"|"Light rain"|"Patchy rain possible"|"Light drizzle"|"Patchy light drizzle"|"Patchy light rain") echo "󰼳" ;;
        "Rain"|"Moderate rain"|"Heavy rain"|"Moderate or heavy rain shower"|"Light rain shower") echo "󰖗" ;;
        "Thunderstorm"|"Thundery outbreaks possible"|"Patchy light rain with thunder"|"Moderate or heavy rain with thunder") echo "󰖓" ;;
        "Snow"|"Light snow"|"Moderate snow"|"Heavy snow"|"Patchy light snow"|"Patchy moderate snow"|"Patchy heavy snow"|"Light snow showers"|"Moderate or heavy snow showers") echo "󰖘" ;;
        "Sleet"|"Light sleet"|"Moderate or heavy sleet"|"Light sleet showers"|"Moderate or heavy sleet showers") echo "󰙿" ;;
        "Blizzard"|"Blowing snow")      echo "󰼴" ;;
        *)                              echo "󰖐" ;;
    esac
}

fetch_weather() {
    weather_data=$(curl -fsS --connect-timeout 10 --max-time 15 --retry 2 --retry-delay 2 \
        "https://wttr.in/?format=%C%0A%t" 2>/dev/null) || return 1
    [ -n "$weather_data" ] || return 1

    condition=$(echo "$weather_data" | head -n 1 | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')
    temp=$(echo "$weather_data" | tail -n 1 | tr -d '+')
    icon=$(get_weather_icon "$condition")
    tooltip="$condition $temp"
    tooltip=${tooltip//\\/\\\\}
    tooltip=${tooltip//\"/\\\"}

    tmp=$(mktemp "$CACHE_FILE.XXXX") || return 1
    printf '{"text": "%s %s", "tooltip": "%s", "class": "weather"}' "$icon" "$temp" "$tooltip" > "$tmp"
    mv -f "$tmp" "$CACHE_FILE"
}

cache_age() {
    local now file_mod
    now=$(date +%s)
    file_mod=$(stat -c %Y "$CACHE_FILE" 2>/dev/null || echo 0)
    echo $(( now - file_mod ))
}

fetch_weather_locked() {
    (
        flock -n 200 || exit 0
        fetch_weather && pkill -RTMIN+9 waybar 2>/dev/null || true
    ) 200>>"$LOCK_FILE"
}

MAX_AGE=900 # 15 minutes

# Show cached data immediately if available
if [ -f "$CACHE_FILE" ]; then
    cat "$CACHE_FILE"
    # Only refresh if cache is older than MAX_AGE
    if [ "$(cache_age)" -ge "$MAX_AGE" ]; then
        fetch_weather_locked > /dev/null 2>&1 &
        disown
    fi
else
    # No cache yet — fetch synchronously, cache it, and output
    fetch_weather
    [ -f "$CACHE_FILE" ] && cat "$CACHE_FILE" || echo '{"text": "󰖐 N/A", "tooltip": "Weather unavailable", "class": "unavailable"}'
fi
