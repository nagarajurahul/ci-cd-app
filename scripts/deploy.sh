#!/bin/bash
set -e

echo "📦 Ensuring Docker is installed and running..."

# Install Docker if not already installed
if ! command -v docker &> /dev/null; then
  echo "🔧 Docker not found. Installing..."
  sudo apt update
  sudo apt install -y docker.io
  sudo systemctl enable docker
  sudo systemctl start docker
else
  echo "✅ Docker is already installed."
fi

# Start Docker if not running
if ! sudo systemctl is-active --quiet docker; then
  echo "▶️ Starting Docker service..."
  sudo systemctl start docker
else
  echo "✅ Docker is already running."
fi

echo "Pulling latest Docker image..."
echo "$DOCKERHUB_TOKEN" | docker login -u "$DOCKERHUB_USERNAME" --password-stdin

docker pull "$DOCKERHUB_USERNAME"/"$DOCKERHUB_IMAGE":"$DOCKERHUB_TAG"

echo "Restarting Docker container..."
docker kill my-app || true
docker rm my-app || true
docker run -d --name "$DOCKER_CONTAINER_NAME" -p 3000:3000 "$DOCKERHUB_USERNAME"/"$DOCKERHUB_IMAGE":"$DOCKERHUB_TAG"
