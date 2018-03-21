# Ups Dock WordPress Starter Kit

This starter kit is used to create the following:

* nginx PHP-FPM container with WordPress
* MySQL container

A database is automatically created, and the wp-config file is configured to use that database.

The following mounts are created:

* Root directory: This is where your theme lives
* `/plugins`: Links to `/wp-content/themes/plugins` in the Docker container
* `/uploads`: Links to `/wp-content/themes/uploads` in the Docker container

This start kit assumes your git repository contains just the WordPress theme. If you're working with a framework that includes the entire WordPress install (i.e. WP Engine, Trellis / Roots) then you should adjust the root volume to point to just `/var/www/html`. 

## Installation

1. Make sure [Ups Dock](https://github.com/Upstatement/ups-dock) is installed and up and running
2. Copy the `starter-kits/wordpress` directory to a new folder where would like your WordPress theme to live.
3. Copy `.env.sample` to `.env` and update to reflect your themes values
4. Update `style.css` to reflect your themes values
5. From the root directory run `./bin/install.sh`

Once completed, you should be able to access your WordPress installation via `ups.dock`. 

If you need to SSH into your container, from your project root run `docker-compose exec wordpress /bin/bash`

## Running

`./bin/start.sh` will start the container. 

Quitting this process (`Ctrl-C`) will shut down the container.

### Importing

There is a basic database import script in `/bin/import.sh`. Just update the SQL file name, old URL, and local URL.

## wp-cli

`docker-compose exec wordpress wp [command]`

## TODO

- `wp-cli` shortcut