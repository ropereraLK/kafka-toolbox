#!/bin/bash

# ============================================
# Kafka Toolbox - Stop Kafka + Zookeeper
# ============================================

echo "🛑 Stopping Kafka..."

# Resolve base directory (project root)
SCRIPT_DIR="$(dirname "$0")"
BASE_DIR="$(cd "$SCRIPT_DIR" && pwd)"

# Load environment variables
ENV_FILE="$BASE_DIR/config/local.env"
if [ -f "$ENV_FILE" ]; then
    echo "📄 Loading config from local.env..."
    set -o allexport
    source "$ENV_FILE"
    set +o allexport
else
    echo "❌ Config file not found: $ENV_FILE"
    exit 1
fi

# Check Docker environment
"$BASE_DIR/util/docker/docker-setup.sh"
if [ $? -ne 0 ]; then
    echo "❌ Docker environment check failed. Exiting."
    exit 1
fi

# Stop Kafka and Zookeeper using Docker Compose V2
echo "📦 Stopping Kafka using docker compose..."
docker compose -f "$BASE_DIR/config/docker-compose.yml" down

if [ $? -eq 0 ]; then
    echo "✅ Kafka and Zookeeper stopped successfully!"
else
    echo "❌ Failed to stop Kafka."
fi
