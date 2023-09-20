FROM nginxproxy/nginx-proxy:1.3.1

COPY config/nginx.conf /etc/nginx/conf.d/ups.conf
COPY config/vhosts /etc/nginx/vhost.d
COPY templates/index.json.tmpl Procfile /app/
COPY www /var/www/html

# Customize proxy-wide nginx configuration
RUN { \
  echo 'client_max_body_size 100m;'; \
} > /etc/nginx/conf.d/proxy.conf

RUN set -ex; \
  chown -R www-data:www-data /var/www/html && \
  find /var/www/html -type d -exec chmod 2755 {} \; && \
  find /var/www/html -type f -exec chmod 644 {} \;
