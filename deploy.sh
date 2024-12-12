#!/bin/bash

# Define the image name
IMAGE_NAME="bioinformatics-tools"

# Build the Docker image
echo "Building Docker image: $IMAGE_NAME..."
docker build -t $IMAGE_NAME .

# Run the Docker container interactively
echo "Running Docker container..."
docker run -it $IMAGE_NAME
