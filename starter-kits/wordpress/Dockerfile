FROM richarvey/nginx-php-fpm:latest

RUN apk add \
  mysql-client \
  openssl \
  msmtp

# Configure msmtp
RUN { \
    echo "account default"; \
    echo "host mailhog"; \
    echo "port 1025"; \
    echo "auto_from on"; \
  } > /etc/msmtprc

# Configure PHP to use msmtp for sending mail
RUN { \
    echo 'sendmail_path = "/usr/bin/msmtp -t -i"'; \
  } > /usr/local/etc/php/conf.d/mail.ini

COPY docker/setup.sh /setup.sh
RUN chmod +x /setup.sh
