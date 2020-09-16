#! /bin/bash


echo '{ "version": 1, "click_events": true }'

echo '['

echo '[]'

(while :;
do
    echo -n ",["
    echo -n "{\"name\":\"id_cpu_usage\",\"background\":\"#283593\",\"full_text\":\"cpu: $(~/.config/i3/i3status/cpu.py)%\"}"
    echo -n ",{\"name\":\"id_disk_usage\",\"background\":\"#283593\",\"full_text\":\"disk: $(~/.config/i3/i3status/disk.py)%\"}"
    echo -n ",{\"name\":\"id_memory_usage\",\"background\":\"#283593\",\"full_text\":\"memory: $(~/.config/i3/i3status/memory.py)%\"}"
    echo -n ",{\"name\":\"id_time\",\"full_text\":\"vol: $(pamixer --get-volume)\"}"
    echo -n ",{\"name\":\"id_time\",\"full_text\":\"$(date)\"}"
    echo -n ",{\"name\":\"id_logout\",\"full_text\":\"logout\"}"
    echo -n "]"
    sleep 0.8
done) &


while read line; do
    if [[ $line == *"name"*"id_time"* ]]; then
        urxvt -e ~/.config/i3/i3status/events/click_time.sh &

    elif [[ $line == *"name"*"id_cpu_usage"* ]]; then
        urxvt -e htop &

    elif [[ $line == *"name"*"id_logout"* ]]; then
        echo ""
    fi
done

local_ip() {

}
