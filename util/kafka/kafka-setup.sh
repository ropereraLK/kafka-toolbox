#!/bin/bash

# ============================================
# Kafka Toolbox - Kafka Setup (Docker)
# ============================================

echo "🔧 Setting up Kafka environment..."

# Resolve base directory (project root)
SCRIPT_DIR="$(dirname "$0")"
BASE_DIR="$(cd "$SCRIPT_DIR/../../" && pwd)"

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

# Pull Kafka Docker image if not present
if ! docker image inspect "apache/kafka:$KAFKA_VERSION" > /dev/null 2>&1; then
    echo "📦 Pulling Kafka Docker image: apache/kafka:$KAFKA_VERSION..."
    docker pull "apache/kafka:$KAFKA_VERSION"
else
    echo "✅ Kafka Docker image already exists: apache/kafka:$KAFKA_VERSION"
fi

# Pull Zookeeper Docker image if not present
if ! docker image inspect "zookeeper:$ZOOKEEPER_VERSION" > /dev/null 2>&1; then
    echo "📦 Pulling Zookeeper Docker image: zookeeper:$ZOOKEEPER_VERSION..."
    docker pull "zookeeper:$ZOOKEEPER_VERSION"
else
    echo "✅ Zookeeper Docker image already exists: zookeeper:$ZOOKEEPER_VERSION"
fi

echo "✅ Kafka environment is ready!"
