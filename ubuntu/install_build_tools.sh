#!/bin/bash

# Clear the screen
clear

# Display a banner
echo "#############################################"
echo "#   Welcome to the System Update Script     #"
echo "#############################################"
echo

# Function to show the dots4 spinner
spinner() {
    local pid=$1
    local delay=0.1
    local dots4=( '⠄' '⠆' '⠇' '⠋' '⠙' '⠸' '⠰' '⠠' '⠰' '⠸' '⠙' '⠋' '⠇' '⠆' )
    while [ -d /proc/$pid ]; do
        for char in "${dots4[@]}"; do
            echo -ne "\r$char Updating system... Please wait."
            sleep $delay
        done
    done
    echo -ne "\r✔ Update complete!                      \n"
}

# Detect the Linux distribution
os=$(grep '^ID=' /etc/os-release | cut -d= -f2 | tr -d '"')

# Perform update and upgrade based on the OS
case "$os" in
    ubuntu|debian)
        export DEBIAN_FRONTEND=noninteractive
        (sudo apt update -y -q > /dev/null 2>&1 && sudo apt upgrade -y -q > /dev/null 2>&1) &
        spinner $!
        ;;
    centos|rhel|fedora)
        (sudo yum update -y -q > /dev/null 2>&1 && sudo yum upgrade -y -q > /dev/null 2>&1) &
        spinner $!
        ;;
    arch|manjaro)
        (sudo pacman -Syu --noconfirm --quiet > /dev/null 2>&1) &
        spinner $!
        ;;
    *)
        echo "Unsupported OS detected. Please update manually."
        exit 1
        ;;
esac

# Completion message
echo "System successfully updated and upgraded!"

# Install build-essential tools (silently)
install_build_tools() {
    case "$os" in
        ubuntu|debian)
            export DEBIAN_FRONTEND=noninteractive
            (sudo apt install -y -q build-essential > /dev/null 2>&1) &
            spinner $!
            ;;
        centos|rhel|fedora)
            (sudo yum groupinstall -y -q "Development Tools" > /dev/null 2>&1) &
            spinner $!
            ;;
        arch|manjaro)
            (sudo pacman -S --noconfirm --quiet base-devel > /dev/null 2>&1) &
            spinner $!
            ;;
        *)
            echo "Unsupported OS detected. Please install build tools manually."
            exit 1
            ;;
    esac
    echo "Build-essential tools successfully installed!"
}

# Call the function to install build tools
install_build_tools
