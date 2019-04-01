# Ups Dock

> Streamline your local development workflow with Docker.

At Upstatement we're [technology agnostic](https://www.upstatement.com/engineers/values.html). We love tooling that enables us to build in any tech stack with minimal fuss, and [shortens the feedback loop](https://vimeo.com/36579366) between changing things and seeing the results. [Docker](https://www.docker.com/) allows us to quickly spin up local development environments with any tech stack and build in a production-like environment, simulatenously solving the "works on my machine" problem, avoiding conflicting dependencies between projects, and keeping our local machines clean.

Ups Dock is our solution to some common pain points we encountered working with Docker, namely automating DNS resolution and SSL certificate management across projects.

## Table of Contents

- [Ups Dock](#ups-dock)
  - [Table of Contents](#table-of-contents)
  - [What's in the Box](#whats-in-the-box)
  - [System Requirements](#system-requirements)
  - [Installation](#installation)
  - [Getting Started](#getting-started)
  - [Making your project work with Ups Dock](#making-your-project-work-with-ups-dock)
  - [Contributing](#contributing)
  - [Code of Conduct](#code-of-conduct)
  - [About Upstatement](#about-upstatement)

## What's in the Box

Ups Dock provides a number of tools designed to streamline the process of spinning up and switching between projects.

- **Dashboard**. Visit https://ups.dock to view all of your Ups Dock-compatible Docker projects.
- **Proxy**. An nginx instance configured to proxy requests to connected containers. Based on [nginx-proxy](https://github.com/jwilder/nginx-proxy).
- **DNS**. A custom DNS server to resolve all `*.ups.dock` host names to the nginx proxy, powered by [dnsmasq](https://github.com/andyshinn/docker-dnsmasq).
- **SSL**. A shared, self-signed wildcard certificate for use with `*.ups.dock` domains.
- **Email**. A fake mail server to intercept e-mails while in development, powered by [Mailhog](https://github.com/mailhog/MailHog).

## System Requirements

- Mac OS Sierra 10.12 and newer
- [Docker Desktop](https://www.docker.com/products/docker-desktop)
- Administrator privileges (the install script requires `sudo` to modify a few system settings related to DNS resolution and trusting SSL certificates).

## Installation

1. Clone this repository

   ```bash
   git clone git@github.com:Upstatement/ups-dock.git && cd ups-dock
   ```

2. Run the install script

   ```bash
   ./bin/install.sh
   ```

3. Visit the [dashboard](https://ups.dock) to view all of your ups.dock sites

   ```bash
   open https://ups.dock
   ```

## Getting Started

We've curated a collection of Ups Dock-compatible starter kits for the most common stacks we're working with these days:

- [Skela (Wordpress + Timber)](https://github.com/Upstatement/skela-wp-theme)
- [Craft CMS](https://github.com/Upstatement/craft-starter)

## Making your project work with Ups Dock

Our starter kits not cutting it? Roll your own!

You can add Ups Dock support to your Docker Compose project with a few simple steps:

1. Add the `VIRTUAL_HOST` and `UPS_DOCK_NAME` environment variables to your web service
2. Add the `ups-dock` external network to your web service
3. Configure your web services' application to use Mailhog (optional)

Here's a minimal `docker-compose.yml` example:

```yaml
version: '3.5'
services:
  web:
    image: your-web-image
    environment:
      # Display name presented on http://ups.dock
      UPS_DOCK_NAME: Example Website
      # Host name you want to use. Must end in `ups.dock`.
      VIRTUAL_HOST: example.ups.dock
      # Allow http and https traffic (default will automatically redirect http -> https)
      HTTPS_METHOD: noredirect
      # Set this if your web service is running on a port other than 80
      # VIRTUAL_PORT: 8080
    networks:
      - proxy
      - default
networks:
  proxy:
    name: ups-dock
    external: true
```

You can route SMTP traffic to the `mailhog` host, port `1025` to catch outgoing email during development. Intercepted email is visible at https://mailhog.ups.dock.

## Contributing

We welcome all contributions to our projects! Filing bugs, feature requests, code changes, docs changes, or anything else you'd like to contribute are all more than welcome! More information about contributing can be found in the [contributing guidelines](.github/CONTRIBUTING.md)

## Code of Conduct

Upstatement strives to provide a welcoming, inclusive environment for all users. To hold ourselves accountable to that mission, we have a strictly-enforced [code of conduct](CODE_OF_CONDUCT.md).

## About Upstatement

[Upstatement](https://www.upstatement.com/) is a digital transformation studio headquartered in Boston, MA that imagines and builds exceptional digital experiences. Make sure to check out our [services](https://www.upstatement.com/services/), [work](https://www.upstatement.com/work/), and [open positions](https://www.upstatement.com/jobs/)!
