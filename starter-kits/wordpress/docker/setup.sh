#!/bin/sh

set -e

# Configure WordPress
echo "Configuring WordPress..."
wp config create --dbname=wordpress --dbuser=wordpress --dbpass=wordpress --dbhost=db:3306 --skip-check --extra-php <<PHP
// This allows the WordPress site to run securly behind the ups-dock reverse proxy
if ( strpos( \$_SERVER['HTTP_X_FORWARDED_PROTO'], 'https' ) !== false ) {
    \$_SERVER['HTTPS'] = 'on';
}
define( 'WP_DEBUG', true );
PHP
