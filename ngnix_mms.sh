#!/bin/bash
#Monitoring Metrics Script with Sleep Mechanism

# Interactive Menu
Interact_menu() {
    echo "Choose from tthe following to view items:"
    echo "1. System usage metrics"
    echo "2. Monitor Nginx Service"
    echo "3. Monitor a Different Service"
    echo "4. exit"
}

#system metrics
system_usages()
{
        echo "1. CPU Usage"
        top -bn 1 | grep '%Cpu' | awk '{print $2}'
        echo "2. Memory Usage"
        free -h
        echo "3. Disk Space"
        df -h
}

# Function to check and start Nginx service
monitor_nginx_service() {
    # Check if Nginx is running
    if systemctl is-active --quiet nginx; then
        echo "Nginx service is running."
    else
        echo "Nginx service is not running."
        read -p "Do you want to start Nginx? (y/n): " choice
        if [[ $choice == "y" ]]; then
            sudo systemctl start nginx
            echo "Nginx service has been started."
        fi
    fi
}

# Function to monitor a specific service
monitor_specific_service() {
    read -p "Enter the name of the service to monitor: " service_name
    if systemctl is-active --quiet "$service_name"; then
        echo "$service_name service is running."
    else
        echo "$service_name service is not running."
    fi
}

# Function for error handling
handle_error() {
    echo "Error: $1"
    exit 1
}

# Clear the screen before the loop starts
clear

# Main script
while true; do
    Interact_menu
    read -p "Enter your choice: " choice
    echo

    case $choice in
        1) system_usages ;;
        2) monitor_nginx_service ;;
        3) monitor_specific_service ;;
        4) exit 0 ;;
        *) handle_error "Invalid choice. Please enter a valid option." ;;
    esac

    echo
    read -p "Press Enter to continue..." -t 3
    echo
done
