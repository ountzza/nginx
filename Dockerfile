#
# Nginx Dockerfile
#
# https://github.com/dockerfile/nginx
#

# Pull base image.
FROM dockerfile/ubuntu

# Install Nginx.
RUN \
  add-apt-repository -y ppa:nginx/stable && \
  apt-get update && \
  apt-get install -y nginx && \
  rm -rf /var/lib/apt/lists/* && \
  echo "\ndaemon off;" >> /etc/nginx/nginx.conf && \
  chown -R www-data:www-data /var/lib/nginx

# Define mountable directories.
VOLUME ["/data", "/etc/nginx/sites-enabled", "/etc/nginx/conf.d", "/var/log/nginx"]

# Define working directory.
WORKDIR /etc/nginx

# Define default command.
CMD ["nginx"]

# Expose ports.
EXPOSE 80
EXPOSE 443

vi default
#############################################
server {
    listen 80 default;
    server_name ui.docker.com;
    location / {
        proxy_pass http://130.211.248.25:8080;
        proxy_read_timeout 900;
    }
}
server {
    listen 80;
    server_name registry.docker.com;
    location / {
        proxy_pass http://130.211.248.25:5000;
        proxy_read_timeout 900;
    }
}
