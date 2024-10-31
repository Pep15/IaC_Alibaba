#!/bin/bash
sudo apt-get update -yy
sudo apt-get install -yy git curl

curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh ./get-docker.sh

git clone https://github.com/Pep15/capstone_Twaq.git
cd capstone_Twaq
docker compose up -d
