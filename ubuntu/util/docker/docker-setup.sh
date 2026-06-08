#!/bin/bash
# utils/docker/setup.sh
# Ensures Docker is installed and running on Linux systems.

echo "🔍 Checking Docker environment..."

# 1. Check if docker command exists
if ! command -v docker &> /dev/null
then
    echo "❌ Docker is not installed!"
    echo "➡ Install it using your package manager or:"
    echo "   https://docs.docker.com/engine/install/"
    exit 1
fi

# 2. Check if Docker daemon is running
if ! docker info &> /dev/null
then
    echo "⚠️ Docker daemon is not running."
    echo "🔄 Attempting to start Docker service..."

    # Try to start docker (Linux only)
    if sudo systemctl start docker; then
        echo "⏳ Waiting for Docker to initialize..."
        sleep 2
    fi

    # Validate Docker again
    if ! docker info &> /dev/null
    then
        echo "❌ Docker could not be started automatically."
        echo "➡ Try running manually: sudo systemctl start docker"
        exit 1
    fi

    echo "✅ Docker daemon started successfully."
fi

echo "✅ Docker is available and running."
exit 0
