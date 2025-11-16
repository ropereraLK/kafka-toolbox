#!/bin/bash

# ============================================
# Kafka Toolbox - Check Status of Kafka + Zookeeper
# ============================================

echo "🔍 Checking Kafka & Zookeeper containers..."

# Resolve base directory (project root)
SCRIPT_DIR="$(dirname "$0")"
BASE_DIR="$(cd "$SCRIPT_DIR" && pwd)"

# Load environment variables
ENV_FILE="$BASE_DIR/config/local.env"
if [ -f "$ENV_FILE" ]; then
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

# Check if containers are running
KAFKA_CONTAINER=$(docker ps --filter "name=kafka" --format '{{.Names}}')
ZOOKEEPER_CONTAINER=$(docker ps --filter "name=zookeeper" --format '{{.Names}}')

if [ -n "$KAFKA_CONTAINER" ]; then
    echo "✅ Kafka container is running: $KAFKA_CONTAINER"
else
    echo "❌ Kafka container is not running"
fi

if [ -n "$ZOOKEEPER_CONTAINER" ]; then
    echo "✅ Zookeeper container is running: $ZOOKEEPER_CONTAINER"
else
    echo "❌ Zookeeper container is not running"
fi