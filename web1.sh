#!/bin/bash
sudo yum -y update
sudo amazon-linux-extras install nginx1.12 -y
sudo systemctl start nginx
sudo systemctl enable nginx
sudo echo "<h1><font color = "brown">Welcome to NGINX!!
I am a student of devops-crash-course-spring-2021.
I am number <b>6</b> in the devops-crash-course-spring-2021
It's a server <b>#1</b> </h1>" > /usr/share/nginx/html/index.html
sudo systemctl nginx restart
