#!/bin/bash

# Prevent notification spamming
LOW_ALERT_SENT=false
HIGH_ALERT_SENT=false

# Pop!_OS desktop sound effect
SOUND_FILE="/usr/share/sounds/freedesktop/stereo/complete.oga"

# Play alert sound 3 times
play_alert() {
    for _ in {1..3}; do
        paplay "$SOUND_FILE"
    done
}

while true; do
    # Get current battery level and status via upower
    BATTERY_LEVEL=$(upower -i $(upower -e | grep BAT) | grep percentage | awk '{print $2}' | tr -d '%')
    BATTERY_STATUS=$(upower -i $(upower -e | grep BAT) | grep state | awk '{print $2}')

    # Alert at 22% while discharging (2% margin before 20%)
    if [ "$BATTERY_STATUS" = "discharging" ] && [ "$BATTERY_LEVEL" -le 22 ] && [ "$LOW_ALERT_SENT" = false ]; then
        play_alert &
        notify-send -u critical -t 0 -i battery-low "Battery Warning" "Battery is down to ${BATTERY_LEVEL}%. Plug in your charger before it drops below 20%!"
        LOW_ALERT_SENT=true
    elif [ "$BATTERY_LEVEL" -gt 22 ]; then
        LOW_ALERT_SENT=false
    fi

    # Alert at 80% while charging
    if [ "$BATTERY_STATUS" = "charging" ] && [ "$BATTERY_LEVEL" -ge 80 ] && [ "$HIGH_ALERT_SENT" = false ]; then
        play_alert &
        notify-send -u critical -t 0 -i battery-full "Charging Target Reached" "Battery reached ${BATTERY_LEVEL}%. Unplug your charger!"
        HIGH_ALERT_SENT=true
    elif [ "$BATTERY_LEVEL" -lt 80 ]; then
        HIGH_ALERT_SENT=false
    fi

    sleep 30
done
