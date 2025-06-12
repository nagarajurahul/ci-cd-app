#!/bin/bash
set -e

echo "📦 Ensuring Docker is installed and running..."

# Check for Docker
if ! command -v docker &> /dev/null; then
  echo "🔧 Docker not found. Installing..."
  # sudo apt update
  # sudo apt install -y docker.io
  sudo dnf update -y
  sudo dnf install -y docker
  sudo systemctl enable docker
  sudo systemctl start docker
else
  echo "✅ Docker is already installed."
fi

# Start Docker if it's not running
if ! sudo systemctl is-active --quiet docker; then
  echo "▶️ Starting Docker service..."
  sudo systemctl start docker
else
  echo "✅ Docker is already running."
fi

echo "🪪 Logging into Docker Hub..."
echo "$DOCKERHUB_TOKEN" | sudo docker login -u "$DOCKERHUB_USERNAME" --password-stdin

echo "⇣ Pulling latest Docker image..."
sudo docker pull "$DOCKERHUB_USERNAME/$DOCKERHUB_IMAGE:$DOCKERHUB_TAG"

echo "🔄 Restarting Docker container..."
# sudo docker stop "$DOCKER_CONTAINER_NAME" || true
sudo docker kill "$DOCKER_CONTAINER_NAME" || true
sudo docker rm "$DOCKER_CONTAINER_NAME" || true
sudo docker run -d --name "$DOCKER_CONTAINER_NAME" -p "$DOCKER_CONTAINER_PORT":"$DOCKER_CONTAINER_PORT"  "$DOCKERHUB_USERNAME/$DOCKERHUB_IMAGE:$DOCKERHUB_TAG"
