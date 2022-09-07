#!/usr/bin/env bash

set -e

if sudo security find-certificate -c ups.dock > /dev/null 2>&1; then
  echo "Removing old certificate from system keychain..."
  sudo security delete-certificate -c ups.dock
fi

echo "Generating wildcard SSL certificate for ups.dock..."
openssl req \
  -config config/openssl.conf \
  -new \
  -sha256 \
  -newkey rsa:2048 \
  -nodes \
  -x509 \
  -days 1825 \
  -extensions req_extensions \
  -keyout certs/ups.dock.key \
  -out certs/ups.dock.crt

echo "Adding trusted certificate to system keychain..."
sudo security add-trusted-cert -d -r trustRoot -k /Library/Keychains/System.keychain certs/ups.dock.crt
