# Ups Dock

> A front-end stack for Docker-based projects at Upstatement

- **Proxy**. An nginx instance configured to proxy requests to connected containers. Based on [nginx-proxy](https://github.com/jwilder/nginx-proxy).
- **DNS**. A custom DNS server to resolve all `*.ups.dock` host names to the nginx proxy, powered by [dnsmasq](https://github.com/andyshinn/docker-dnsmasq).
- **SSL**. A shared, self-signed wildcard certificate for use with `*.ups.dock` domains.
- **Email**. A fake mail server to intercept e-mails while in development, powered by [Mailhog](https://github.com/mailhog/MailHog).

## Usage

1. Clone this repository

    ```
    git clone git@github.com:Upstatement/ups-dock.git
    ```

2. Run the install script

    ```
    cd ups-dock
    ./bin/install.sh
    ```

3. Visit the [dashboard](https://ups.dock) to view all of your ups.dock sites

    ```
    open https://ups.dock
    ```

## Project Setup

You can add Ups Dock support to your project in two step

1. Add the `VIRTUAL_HOST` and `UPS_DOCK_NAME` environment variables to your web service
2. Add the `ups-dock` external network to your web service
3. Configure your web services' application to use Mailhog (optional)

Here's a minimal `docker-compose.yml` example:

```yaml
version: '3.5'
services:
    web:
        build: .
        environment:
            # Display name presented on http://ups.dock
            UPS_DOCK_NAME: Example Website
            # Host name you want to use. Must end in `ups.dock`.
            VIRTUAL_HOST: example.ups.dock
            # Allow http and https traffic (default will automatically redirect http -> https)
            HTTPS_METHOD: noredirect
        networks:
            - proxy
            - default
networks:
    proxy:
        name: ups-dock
        external: true
```

