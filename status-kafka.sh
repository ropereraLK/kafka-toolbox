#!/bin/bash

# ============================================
# Kafka Toolbox - Status Check (3 Brokers)
# ============================================

echo "🔍 Checking Kafka status..."

# Resolve base directory
SCRIPT_DIR="$(dirname "$0")"
BASE_DIR="$(cd "$SCRIPT_DIR" && pwd)"

# Load environment variables
ENV_FILE="$BASE_DIR/config/local.env"
if [ ! -f "$ENV_FILE" ]; then
    echo "❌ Environment file not found: $ENV_FILE"
    exit 1
fi

set -o allexport
source "$ENV_FILE"
set +o allexport

# Check Docker environment
"$BASE_DIR/util/docker/docker-setup.sh"
if [ $? -ne 0 ]; then
    echo "❌ Docker environment check failed. Exiting."
    exit 1
fi

# Check Kafka containers
BROKERS=("kafka1" "kafka2" "kafka3")
for broker in "${BROKERS[@]}"; do
    status=$(docker inspect -f '{{.State.Running}}' $broker 2>/dev/null)
    if [ "$status" == "true" ]; then
        echo "✅ $broker is running."
    else
        echo "❌ $broker is NOT running."
    fi
done

# Optional: show leader/replica info for topics using kafka-topics.sh
echo "ℹ️ Topic partitions (leaders/replicas):"
docker exec -it kafka1 kafka-topics.sh --bootstrap-server localhost:${BROKER1_PORT} --describe
