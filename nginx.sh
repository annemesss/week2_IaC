#!/bin/bash
sudo yum -y update
sudo amazon-linux-extras install nginx1.12 -y
sudo yum -y install git
cd /etc/nginx/
sudo rm -f nginx.conf
sudo git clone https://github.com/annemesss/week2.git
cd week2
sudo mv test.conf /etc/nginx/
cd /etc/nginx/
sudo mv test.conf nginx.conf
sed -i "s/127.0.0.1:8081/${ip_web1}:80/g" nginx.conf
sed -i "s/127.0.0.1:8082/${ip_web2}:80/g" nginx.conf
sudo systemctl start nginx
sudo systemctl enable nginx
sudo systemctl restart nginx
