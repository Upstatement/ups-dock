#!/bin/sh

set -e

# Install WP cli
echo "Installing WP Cli..."
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp

# Download WordPress
echo "Installing WordPress..."
cd /var/www/html
wp core download --path=/var/www/html --allow-root
wp config create --dbname=wordpress --dbuser=wordpress --dbpass=wordpress --dbhost=db:3306 --skip-check --allow-root

# This allows the WordPress site to run securly behind the ups-dock reverse proxy
sed -i "67i if (strpos(\$_SERVER['HTTP_X_FORWARDED_PROTO'], 'https') !== false)" wp-config.php
sed -i "68i     \$_SERVER['HTTPS']='on';" wp-config.php
sed -i "69i define( 'WP_DEBUG', true );" wp-config.php
