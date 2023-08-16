#!/bin/bash

process_name=$1

#process existence check
function check_process_running() {
    if pgrep -x "$process_name" >/dev/null; then
        echo "The process $process_name is running."
        return 0
    else
        echo "The process $process_name is not running."
        return 1
    fi
}

#restart process

max_attempts=3
current_attempt=1
function restart_process() {
    echo "Restarting $process_name..."
    systemctl restart "$process_name"
}

while true; do
    if check_process_running; then
        break
    fi

    if [ "$current_attempt" -le "$max_attempts" ]; then
        restart_process
        current_attempt=$((current_attempt + 1))

    else
        echo "Max restart attempts reached. Exiting..."
        echo "Please try to restart the process manually."
        exit 1
    fi
done
