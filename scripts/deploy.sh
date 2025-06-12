#!/bin/bash
set -e

echo "📦 Ensuring Docker is installed and running..."

# Check for Docker
if ! command -v docker &> /dev/null; then
  echo "🔧 Docker not found. Installing with dnf..."
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

echo "Pulling latest Docker image..."
echo "$DOCKERHUB_TOKEN" | sudo docker login -u "$DOCKERHUB_USERNAME" --password-stdin

sudo docker pull "$DOCKERHUB_USERNAME/$DOCKERHUB_IMAGE:$DOCKERHUB_TAG"

echo "Restarting Docker container..."
sudo docker kill "$DOCKER_CONTAINER_NAME" || true
sudo docker rm "$DOCKER_CONTAINER_NAME" || true
sudo docker run -d --name "$DOCKER_CONTAINER_NAME" -p 3000:3000 "$DOCKERHUB_USERNAME/$DOCKERHUB_IMAGE:$DOCKERHUB_TAG"
