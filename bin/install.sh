#!/usr/bin/env bash

set -e

# Generate SSL certificates
./bin/gen-certs.sh

# Ensure /etc/resolver exists before usage
if [ ! -d /etc/resolver ]; then
  echo "Creating /etc/resolver..."
  sudo mkdir /etc/resolver
fi

# Add DNS resolver
if [ ! -f /etc/resolver/ups.dock ]; then
  echo "Adding DNS resolver for ups.dock..."
  echo -e "nameserver 127.0.0.1\nport 53535\n" | sudo tee /etc/resolver/ups.dock
fi

# Start Docker containers
echo "Starting ups-proxy and dnsmasq..."
docker compose up --build -d

echo "All done!"
echo "........."
echo "View all of your local sites here: https://ups.dock"
