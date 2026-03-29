#!/bin/bash

SERIAL_PORT="/dev/ttyUSB0"
INTERVAL=10

SPEED_NORMAL=10
SPEED_WARM=50
SPEED_HOT=100

TEMP_WARN=45
TEMP_HIGH=55

DRIVES=(/dev/sde /dev/sdf /dev/sdg /dev/sdh /dev/sdi /dev/sdj /dev/sdk /dev/sdl /dev/sdm /dev/sdn /dev/sdo /dev/sdp)

# Configure serial port: 38400 baud, 8N1, no flow control
stty -F "$SERIAL_PORT" 38400 cs8 -cstopb -parenb -crtscts raw -echo

set_fan_speed() {
    local speed=$1
    echo -en "set_speed ${speed}\r" > "$SERIAL_PORT"
    echo "$(date '+%Y-%m-%d %H:%M:%S') Fan speed set to: ${speed}"
}

get_max_temp() {
    local max_temp=0

    for drive in "${DRIVES[@]}"; do
        [ -b "$drive" ] || continue

        local temp
        temp=$(smartctl -A "$drive" 2>/dev/null | awk '/^Current Drive Temperature:/ { print $4 }')

        if [[ -n "$temp" && "$temp" -gt "$max_temp" ]]; then
            max_temp=$temp
        fi
    done

    echo "$max_temp"
}

current_speed=0

while true; do
    max_temp=$(get_max_temp)
    # Get current time in HHMM format (e.g., "1200" for Noon)

    current_time=$(date +%H%M)

    # Check if the time is between 12:00 and 12:02 (inclusive)
    if [[ "$current_time" -ge "1200" && "$current_time" -lt "1205" ]]; then
        target_speed=$SPEED_HOT
        echo "$(date '+%Y-%m-%d %H:%M:%S') *** Daily Drive Blowout Active ***"
    elif [[ "$max_temp" -ge "$TEMP_HIGH" ]]; then
        target_speed=$SPEED_HOT
    elif [[ "$max_temp" -ge "$TEMP_WARN" ]]; then
        target_speed=$SPEED_WARM
    else
        target_speed=$SPEED_NORMAL
    fi

    if [[ "$target_speed" != "$current_speed" ]]; then
        current_speed=$target_speed
    fi

    echo "$(date '+%Y-%m-%d %H:%M:%S') Max temp: ${max_temp}C — speed: ${current_speed}"
    set_fan_speed "$current_speed"

    sleep "$INTERVAL"
done
