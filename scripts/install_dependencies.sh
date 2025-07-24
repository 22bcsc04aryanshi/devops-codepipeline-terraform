#!/bin/bash
sudo apt update -y
sudo apt install -y nginx
echo "<h1>Deployment successful!</h1>" | sudo tee /var/www/html/index.html
