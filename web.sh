#!/bin/bash

echo "star provision web"$1
sudo yum update
sudo yum install -y epel-release
sudo yum install -y nginx
echo "<h1> bla bla bla this is web"$1"</h1>" >> /usr/share/nginx/html/index.html
echo "web'$1' completed"
sudo systemctl enable nginx
sudo systemctl start nginx
