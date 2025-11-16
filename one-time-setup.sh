#!/bin/bash
# ============================================
# Kafka Toolbox - One-time Setup Script
# ============================================

echo "⚡ Kafka Toolbox - One-time setup"

# Recursively make all shell scripts executable
find . -type f -name "*.sh" -exec chmod +x {} \;

echo "✅ All script permissions have been set."

echo "
💡 This is a one-time setup. You can now run:
    ./start-kafka.sh
    ./stop-kafka.sh
    ./status-kafka.sh
"
