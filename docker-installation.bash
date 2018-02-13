#!/bin/bash
# WSL + Docker + Docker Compose Install

# Retrieve Docker Channel Option from user
read -p "Docker Channel (stable/edge): " input_docker_channel_version
if [[ $input_docker_channel_version = "stable" ]] || [[ -z "$input_docker_channel_version" ]]
then
    DOCKER_CHANNEL=stable
else
    DOCKER_CHANNEL=edge
fi

# Retrieve Docker-Compose Version
read -p "Docker-Compose Version (latest): " input_docker_compose_version
if [[ $input_docker_compose_version = "latest" ]] || [[ -z "$input_docker_compose_version" ]]
then
    DOCKER_COMPOSE_VERSION=`git ls-remote https://github.com/docker/compose | grep refs/tags | grep -oP "[0-9]+\.[0-9][0-9]+\.[0-9]+$" | tail -n 1`
else
    DOCKER_COMPOSE_VERSION=$input_docker_compose_version
fi

# Retrieve Shared Drive location, fix mounting differences between WSL and Docker for Windows
read -p "Docker Volume Mount Path Letter: " path
if [ -d "/mnt/$path" ]; then
	mkdir /$path
	mount --bind /mnt/$path /$path
	echo "mount --bind /mnt/$path /$path" >> ~/.bashrc
else
	echo "Path could not be found: /mnt/$path";
fi

# Update the apt package index.
sudo apt-get update

# Install packages to allow apt to use a repository over HTTPS.
sudo apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common

# Add Docker's official GPG key.
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

# Verify the fingerprint.
sudo apt-key fingerprint 0EBFCD88

# Pick the release channel.
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   ${DOCKER_CHANNEL}"

# Update the apt package index.
sudo apt-get update

# Install the latest version of Docker CE.
sudo apt-get install -y docker-ce

# Allow your user to access the Docker CLI without needing root.
sudo usermod -aG docker $USER

# Install Docker Compose.
# TBD get latest version of compose -> https://github.com/docker/compose/releases/latest
sudo curl -L https://github.com/docker/compose/releases/download/${DOCKER_COMPOSE_VERSION}/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose &&
sudo chmod +x /usr/local/bin/docker-compose

# Set up remote docker connection
echo "export DOCKER_HOST=tcp://localhost:2375" >> ~/.bashrc
