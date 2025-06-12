#!/bin/bash
echo "Pulling latest Docker image..."
echo "$DOCKERHUB_TOKEN" | docker login -u "$DOCKERHUB_USERNAME" --password-stdin

docker pull "$DOCKERHUB_USERNAME"/"$DOCKERHUB_IMAGE":"$DOCKERHUB_TAG"

echo "Restarting Docker container..."
docker kill my-app || true
docker rm my-app || true
docker run -d --name "$DOCKER_CONTAINER_NAME" -p 3000:3000 "$DOCKERHUB_USERNAME"/"$DOCKERHUB_IMAGE":"$DOCKERHUB_TAG"
