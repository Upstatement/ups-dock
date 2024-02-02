#!/usr/bin/env bash

set -e

if sudo security find-certificate -c ups.dock > /dev/null 2>&1; then
  echo "Removing old certificate from system keychain..."
  sudo security delete-certificate -c ups.dock
fi

echo "Removing DNS resolver for ups.dock..."
sudo rm -rf /etc/resolver/ups.dock

echo "Destroying containers..."
docker compose down -v --remove-orphans

echo "Done!"
