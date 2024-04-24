#!/bin/bash

brightness=$(brightnessctl get)

lastNotificationId=$(tail -1 ~/.config/Scripts/Memory/brightnessNotificationMemory.txt)

max_brightness=$(brightnessctl max | tr -d '\n')
percentage=$((brightness * 100 / max_brightness))

notification="brightness: $percentage%"

icon_low="~/.config/Scripts/Assets/outline_light_mode_black_24dp.png"
icon_high="~/.config/Scripts/Assets/baseline_light_mode_black_24dp.png.png"

if ((percentage <= 50)); then
    icon="$icon_low"
else
    icon="$icon_high"
fi

currentNotificationID=$(notify-send -p -r $lastNotificationId "Current brightness" "$notification" --icon="$icon")

echo $currentNotificationID >> ~/.config/Scripts/Memory/brightnessNotificationMemory.txt


