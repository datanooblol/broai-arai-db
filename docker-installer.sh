#!/bin/bash

set -e  # Exit immediately if a command exits with a non-zero status

echo "🔧 Updating system packages..."
sudo apt-get update -y
sudo apt-get install -y ca-certificates curl gnupg lsb-release

echo "🔐 Adding Docker’s official GPG key..."
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg \
  | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

echo "🏷️ Setting up Docker repository..."
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
  https://download.docker.com/linux/ubuntu noble stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

echo "🔄 Updating package index with Docker repo..."
sudo apt-get update -y

echo "📦 Installing Docker Engine and CLI..."
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

echo "✅ Verifying Docker installation..."
sudo docker version

echo "🔓 Adding current user to 'docker' group..."
sudo usermod -aG docker $USER

echo "✅ Docker installed successfully!"
echo "🔁 Please log out and log back in to apply 'docker' group membership."
