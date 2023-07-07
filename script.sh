#!/bin/bash

# Update & Upgrade the system
sudo apt update && apt upgrade

# Install dependencies 
sudo apt install -y apt-transport-https ca-certificates curl software-properties-common

# ADD the Officiel GPG key to docker
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

# repository to the APT sources
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Update package and install Docker
sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io

# Run a test container to check if everythings is working
printf "\n-------> Creating hello-world containers for testing purpose\n"
sudo docker run hello-world || echo "-------> Running container command failed"

# Remove all the hello-world containers
printf "\n----> Removing hello-world containers \n"
sudo docker rm $(sudo docker ps -a --filter ancestor=hello-world -q) || echo "-------> Remove container part failed "

# Remove the hello-world image
printf "\n----> Removing hello-world image"
sudo docker image rm hello-world

printf "\nEND OF THE INSTALLATION\n"
sudo docker --version
