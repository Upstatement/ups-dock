#!/bin/bash

set -e

create_containers() {
  docker-compose up --build -d
}

echo "Bringing up project containers..."
echo
create_containers
echo

echo "-------------------------------"
echo "Install completed successfully!"
echo "-------------------------------"
echo


