#!/bin/bash

# Clear the screen
clear

# Display a banner
echo "#############################################"
echo "#   Jenkins Installation Script             #"
echo "#############################################"
echo

# Function to show the dots4 spinner
spinner() {
    local pid=$1
    local delay=0.1
    local dots4=( '⠄' '⠆' '⠇' '⠋' '⠙' '⠸' '⠰' '⠠' '⠰' '⠸' '⠙' '⠋' '⠇' '⠆' )
    while [ -d /proc/$pid ]; do
        for char in "${dots4[@]}"; do
            echo -ne "\r$char Installing Jenkins... Please wait."
            sleep $delay
        done
    done
    echo -ne "\r✔ Jenkins installation complete!                      \n"
}

# Ask the user how much memory to allocate for Jenkins
read -p $'\e[32mHow much memory (in GB) do you want to allocate to Jenkins? (Default: 2GB) \e[0m' memory
memory=${memory:-2} # Default to 2GB if no input
memory=$((memory * 1024)) # Convert GB to MB

# Update and install necessary dependencies
export DEBIAN_FRONTEND=noninteractive
(sudo apt update -y -q > /dev/null 2>&1 && \
sudo apt install -y -q fontconfig openjdk-17-jre wget > /dev/null 2>&1) &
spinner $!

# Verify Java installation
java -version > /dev/null 2>&1
if [ $? -ne 0 ]; then
    echo "Java installation failed. Exiting."
    exit 1
fi

# Add Jenkins repository and GPG key
(sudo wget -q -O /usr/share/keyrings/jenkins-keyring.asc \
  https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key > /dev/null 2>&1 && \
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null && \
sudo apt-get update -y -q > /dev/null 2>&1) &
spinner $!

# Install Jenkins
(sudo apt-get install -y -q jenkins > /dev/null 2>&1) &
spinner $!

# Configure Jenkins memory settings
sudo bash -c "cat <<EOL >> /etc/systemd/system/jenkins.service.d/override.conf
[Service]
# Arguments for the Jenkins JVM
Environment=\"JAVA_OPTS=-Xmx${memory}M -Djava.awt.headless=true\"
EOL" > /dev/null 2>&1

sudo systemctl daemon-reload > /dev/null 2>&1

# Update `/etc/default/jenkins` with memory settings
sudo sed -i "s|^JAVA_ARGS=.*|JAVA_ARGS=\"-Djava.awt.headless=true -Xmx${memory}m -Xms${memory}m\"|" /etc/default/jenkins

# Start Jenkins
sudo systemctl start jenkins > /dev/null 2>&1

# Wait for Jenkins to generate the initial password
sleep 10

# Extract the initial admin password
admin_password=$(sudo cat /var/lib/jenkins/secrets/initialAdminPassword)

# Get the server's IP address
server_ip=$(hostname -I | awk '{print $1}')

# Display completion message with password and server details
echo "#############################################"
echo "Jenkins successfully installed and configured!"
echo "Access Jenkins at: http://${server_ip}:8080"
echo -e "Initial Admin Password: \e[32m$admin_password\e[0m"
echo "#############################################"
