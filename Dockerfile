FROM jwilder/nginx-proxy

COPY config/nginx.conf /etc/nginx/conf.d/ups.conf
COPY templates/index.json.tmpl Procfile /app/
COPY www /var/www/html

RUN set -ex; \
    chown -R www-data:www-data /var/www/html && \
    find /var/www/html -type d -exec chmod 2755 {} \; && \
    find /var/www/html -type f -exec chmod 644 {} \;
