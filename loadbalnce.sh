#!/bin/bash

echo "starting provision"
sudo yum update
sudo yum install -y epel-release
sudo yum install -y nginx
sudo systemctl stop nginx
sudo mv /etc/nginx/nginx.conf /tmp
sudo sed '37,58d' /tmp/nginx.conf > /etc/nginx/nginx.conf
echo "upstream testapp {
		server 10.0.1.12;
		server 10.0.1.13;
	}
server {
	listen 80 default_server;
	listen [::]:80 default_server;

	root /usr/share/nginx/html;
	index index.html index.htm;

	server_name localhost;

	location / {
		proxy_pass http://testapp;
	}
}" >> /etc/nginx/conf.d/load-balncer.conf

sudo systemctl enable nginx
sudo systemctl start nginx
echo "machine lb" >> /usr/share/nginx/html/index.html
echo "provision complated"
