#!/bin/bash

set -e

stop_containers() {
  echo "Shutting off containers..."
  echo
  docker-compose stop
  echo
  echo "All done!"
}

trap stop_containers SIGINT

echo "Starting WordPress..."
echo
docker-compose up -d
echo

echo "Running composer install..."
echo
docker-compose exec nginx-php-fpm composer install
echo

echo "Running npm install..."
echo
npm install
echo

echo "Starting static dev server.."
echo
npm run watch
echo