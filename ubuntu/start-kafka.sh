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

if [ $? -ne 0 ]; then
    echo "❌ Failed to start Kafka."
    exit 1
fi

# Wait for all brokers to be ready
BROKER_PORTS=($BROKER1_PORT $BROKER2_PORT $BROKER3_PORT)
for PORT in "${BROKER_PORTS[@]}"; do
    until nc -z localhost $PORT 2>/dev/null; do
        echo "⏳ Waiting for Kafka broker on port $PORT..."
        sleep 2
    done
done

echo "✅ Kafka started successfully!"
echo "📡 Brokers running on: localhost:${BROKER1_PORT}, localhost:${BROKER2_PORT}, localhost:${BROKER3_PORT}"
