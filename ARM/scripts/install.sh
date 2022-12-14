#!/bin/bash

sudo apt-get update
sudo apt-get install -y ca-certificates curl gnupg lsb-release git unzip

sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor --yes -o /etc/apt/keyrings/docker.gpg 
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin

usermod -aG docker ubuntu

sudo apt-get autoremove -y

sudo curl -L "https://github.com/docker/compose/releases/download/v2.12.2/docker-compose-linux-x86_64" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

sudo mkdir /home/ubuntu/
sudo wget https://codeload.github.com/move-language/move/zip/refs/heads/main -O /home/ubuntu/move.zip
sudo unzip /home/ubuntu/move.zip -d /home/ubuntu/move
cd /home/ubuntu/move && git clone https://github.com/pontem-network/dove.git
