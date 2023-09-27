#!/bin/bash
#Installing Python, GO and Docker
echo -e "\e[34mInstalling Dependencies\e[0m"
sudo apt install -y git python3 python3-pip
sudo apt install -y golang-go
sudo apt-get remove docker docker-engine docker.io containerd runc
sudo apt-get update -y
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
sudo systemctl restart docker
sudo usermod -aG docker $USER
 
#Installing Mythic, Agents and Profiles
echo -e "\e[34mInstalling Mythic, Agents and Profiles\e[0m"
cd /opt
git clone https://github.com/its-a-feature/Mythic
cd Mythic
sudo make
echo -e "\e[34mInstalling modules for Mythic\e[0m"
./mythic-cli install github https://github.com/MythicAgents/Athena
./mythic-cli install github https://github.com/MythicAgents/freyja
./mythic-cli install github https://github.com/MythicAgents/Apollo.git
./mythic-cli install github https://github.com/MythicAgents/merlin
./mythic-cli install github https://github.com/MythicAgents/medusa
./mythic-cli install github https://github.com/MythicAgents/leviathan
./mythic-cli install github https://github.com/MythicC2Profiles/http
./mythic-cli install github https://github.com/MythicC2Profiles/discord
./mythic-cli install github https://github.com/MythicC2Profiles/dynamichttp
./mythic-cli install github https://github.com/MythicC2Profiles/tcp
./mythic-cli install github https://github.com/MythicC2Profiles/websocket
sudo ./mythic-cli start

#Login Info
echo -e "\e[34mMythic login:\e[0m"
ip=$(ip addr show eth0 | grep "inet\b" | awk '{print $2}' | cut -d/ -f1)
port="7443"
url="https://${ip}:${port}"
echo "URL: $url"
echo "Default username: mythic_admin"
cd /opt/Mythic
sudo cat .env | grep MYTHIC_ADMIN_PASSWORD