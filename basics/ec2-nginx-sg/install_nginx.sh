#!/bin/bash
#add nginx repo
amazon-linux-extras install epel -y
#install nginx
amazon-linux-extras install nginx1 -y
systemctl start nginx
systemctl enable nginx