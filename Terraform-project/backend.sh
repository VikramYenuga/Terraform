#! /bin/bash
yum install git -y
sudo yum install mariadb-105-server -y
sudo dnf install -y nodejs
npm install
npm install -g pm2
pm2 start index.js --name --node-app