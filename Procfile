dockergen: docker-gen -watch -notify "nginx -s reload" /app/nginx.tmpl /etc/nginx/conf.d/default.conf
upsindex: docker-gen -watch -include-stopped /app/index.json.tmpl /var/www/html/index.json
nginx: nginx
