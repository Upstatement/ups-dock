#!/bin/bash

set -e

create_containers() {
  docker-compose up --build -d
}

wait_for_containers() {
  amount=${1:-5}
  sleep $amount
}

wordpress_install() {  
    docker-compose exec nginx-php-fpm /setup.sh
}


echo "Bringing up project containers..."
echo
create_containers
echo

echo "Waiting for containers to finish starting..."
wait_for_containers

echo "Running WordPress installation script on container..."
echo
wordpress_install
echo

echo "-------------------------------"
echo "Install completed successfully!"
echo "-------------------------------"
echo


