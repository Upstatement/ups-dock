#!/bin/sh

set -e

wp config create --dbname=wordpress --dbuser=wordpress --dbpass=wordpress --dbhost=db:3306 --skip-check --allow-root

# This allows the WordPress site to run securly behind the ups-dock reverse proxy
sed -i "67i if (strpos(\$_SERVER['HTTP_X_FORWARDED_PROTO'], 'https') !== false)" wp-config.php
sed -i "68i     \$_SERVER['HTTPS']='on';" wp-config.php
sed -i "69i define( 'WP_DEBUG', true );" wp-config.php
