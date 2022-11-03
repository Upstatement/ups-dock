# Provide a file matching the name of each vhost to override
# in this case, the vhost would be `route.subdomain.com`

# It is recommended to set proxy buffer sizes to only what is required,
# therefore we highly suggest you reduce your default values. Your header
# content size can be determined via cURL, postman, etc

# Remove leading hash to enable below directives

# proxy_buffering on;
# proxy_busy_buffers_size 512k;
# proxy_buffers 4 512k;
# proxy_buffer_size 256k;

# for more information on available directives, visit the nginx documentation:
# https://docs.nginx.com/nginx/admin-guide/basic-functionality/managing-configuration-files/
