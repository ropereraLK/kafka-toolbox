#!/bin/bash

# ============================================
#  Kafka Toolbox - Start Kafka (Docker)
# ============================================

echo "🚀 Starting Kafka..."

# Resolve project base directory (assuming script in project root)
SCRIPT_DIR="$(dirname "$0")"
BASE_DIR="$(cd "$SCRIPT_DIR" && pwd)"

# Load environment variables from local.env
ENV_FILE="$BASE_DIR/config/local.env"
if [ ! -f "$ENV_FILE" ]; then
    echo "❌ Environment file not found: $ENV_FILE"
    exit 1
fi

# Export variables
set -o allexport
source "$ENV_FILE"
set +o allexport

# Check Docker environment
"$BASE_DIR/util/docker/docker-setup.sh"
if [ $? -ne 0 ]; then
    echo "❌ Docker environment check failed. Exiting."
    exit 1
fi

# Check Kafka Docker image
"$BASE_DIR/util/kafka/kafka-setup.sh"
if [ $? -ne 0 ]; then
    echo "❌ Kafka Docker image setup failed. Exiting."
    exit 1
fi

# Start Kafka using docker-compose
echo "📦 Starting Kafka using docker-compose..."
docker compose -f "$BASE_DIR/config/docker-compose.yml" up -d

if [ $? -eq 0 ]; then
    echo "✅ Kafka started successfully!"
    echo "📡 Brokers running on: localhost:9092"
else
    echo "❌ Failed to start Kafka."
    exit 1
fi
