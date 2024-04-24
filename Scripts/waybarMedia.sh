playStatus=$(playerctl status)

if ! command -v playerctl &> /dev/null; then
    echo "{\"text\": \"playerctl is not installed\", \"class\": \"error\"}"
    exit 1
fi

if ! playerctl status &> /dev/null; then
    echo "{\"text\": \"No media player is running\", \"class\": \"error\"}"
    exit 1
fi

if [ $# -ne 1 ]; then
    echo "{\"text\": \"Usage: $0 (status|playpause|previous|next)\", \"class\": \"error\"}"
    exit 1
fi

case "$1" in
    status)
        if [ $(playerctl status) = "Playing" ]; then
            icon="󰏤"
        else [ $(playerctl status) = "Paused" ]; 
            icon="󰐊"
        fi
        title=$(playerctl metadata xesam:title)
        artist=$(playerctl metadata xesam:artist)
        echo "{\"text\": \"$icon $title • $artist\", \"class\": \"normal\"}"
    ;;
    playpause)
        playerctl play-pause
    ;;
    previous)
        playerctl previous
    ;;
    next)
        playerctl next
    ;;
    *)
        echo "{\"text\": \"Invalid argument. Usage: $0 (status|playpause|previous|next)\", \"class\": \"error\"}"
        exit 1
    ;;
esac
