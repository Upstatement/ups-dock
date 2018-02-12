#!/bin/bash

set -e

echo "Importing database..."
docker-compose exec nginx-php-fpm wp --allow-root db import dbdump.sql
echo "Replacing live URLs with localURLs"
docker-compose exec nginx-php-fpm wp --allow-root search-replace www.OLDHOST.com NEWHOST.ups.dock
