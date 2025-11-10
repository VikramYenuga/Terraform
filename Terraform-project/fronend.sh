#! /bin/bash
sudo yum install git -y
sudo dnf install -y nodejs
npm install 
npm start
npm run build
yum install httpd -y
systemctl start httpd
systemctl status httpd
systemctl enable httpd