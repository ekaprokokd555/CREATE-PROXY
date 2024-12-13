#!/bin/bash

# Update system and install Squid
echo "Updating system and installing Squid..."
sudo apt update && sudo apt upgrade -y
sudo apt install squid -y

# Backup default config
echo "Backing up default Squid configuration..."
sudo cp /etc/squid/squid.conf /etc/squid/squid.conf.backup

# Configure Squid
echo "Configuring Squid..."
sudo sed -i 's/^http_port 3128$/http_port 3128/' /etc/squid/squid.conf
echo "acl allowed_clients src 0.0.0.0/0" | sudo tee -a /etc/squid/squid.conf
echo "http_access allow allowed_clients" | sudo tee -a /etc/squid/squid.conf
echo "http_access deny all" | sudo tee -a /etc/squid/squid.conf

# Restart Squid service
echo "Restarting Squid service..."
sudo systemctl restart squid

# Check Squid status
echo "Checking Squid service status..."
sudo systemctl status squid
