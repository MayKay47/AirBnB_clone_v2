#!/usr/bin/env bash
# Set up my web servers for deployment of web-static

# Install Nginx if it's not already installed
if ! [ -x "$(command -v nginx)" ]; then
    sudo apt-get update
    sudo apt-get install nginx -y
fi

# Create necessary directories (use -p to create all parent directories if not existing)
sudo mkdir -p /data/web_static/releases/test /data/web_static/shared

# Give ownership to the ubuntu user and group
sudo chown -R ubuntu /data/
sudo chgrp -R ubuntu /data/
sudo chown -hR ubuntu:ubuntu /data/

# Create a fake HTML file for testing
echo "<html><body>HBNB Static Test</body></html" | sudo tee /data/web_static/releases/test/index.html

# create a symbolic link
# -s: symbolic link, -f: forces if the link already exists
sudo ln -sf /data/web_static/releases/test/ /data/web_static/current

# server name not specified
# listen to port 80
# [::] listens to IPv6 connections
# add_header adds a header to the response indicating the server name $HOSTNAME
# root is the root directory of the server where nginx will look for files to serve
# index is the default file that nginx will serve if no file is specified in the URL
# location is the path to the content to be served '/hbnb_static' path to url - https://mydomain.com/hbnb_static
# alias is the path to the content to be served '/data/web_static/current'. check how to use 'root' and 'alias' in nginx
# return 301 redirects the client to another URL
# error_page 404 is the path to the custom 404 page
# internal is used to prevent nginx from serving the page to the client
printf %s "server {
    listen 80 default_server;
    listen [::]:80 default_server;
    add_header X-Served-By $HOSTNAME;
    root   /var/www/html;
    index  index.html index.htm index.nginx-debian.html;
    location /hbnb_static {
        alias /data/web_static/current;
        index index.html index.htm index.nginx-debian.html;
    }
    location /redirect_me {
        return 301 https://www.linkedin.com/in/mayen-kalu-inim;
    }
    error_page 404 /error_404.html;
    location /404 {
      root /var/www/html;
      internal;
    }
}" > /etc/nginx/sites-available/default

sudo service nginx restart