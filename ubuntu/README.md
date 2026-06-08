# Kafka Toolbox

A lightweight toolkit to run **Apache Kafka** and **Zookeeper** locally using Docker Compose, with easy start/stop/status scripts.

---

## Project Structure

```
kafka-toolbox/
├── one-time-setup.sh       # One-time setup: fixes permissions for all scripts
├── start-kafka.sh          # Start Kafka + Zookeeper
├── stop-kafka.sh           # Stop Kafka + Zookeeper
├── status-kafka.sh         # Check if containers are running
├── config/
│   ├── local.env           # Kafka & Zookeeper versions and config
│   └── docker-compose.yml  # Docker Compose file for Kafka + Zookeeper
└── util/
    ├── docker/
    │   └── docker-setup.sh # Check Docker installation and daemon
    └── kafka/
        └── kafka-setup.sh  # Pull Kafka & Zookeeper images if needed
```

---

## Prerequisites

- Linux system
- [Docker](https://docs.docker.com/get-docker/)
- Docker Compose (V2 plugin included in Docker)

> The scripts include checks for Docker installation and daemon.

---

## One-time Setup

Run the setup script once to fix permissions for all scripts:

```bash
chmod +x one-time-setup.sh
./one-time-setup.sh
```

This ensures you can run all scripts without permission issues.

---

## Configuration

Edit `config/local.env` to set your desired Kafka & Zookeeper versions:

```bash
KAFKA_VERSION=4.1.1
ZOOKEEPER_VERSION=3.9.0
DOCKER_NETWORK=kafka-network
```

---

## Start Kafka

```bash
./start-kafka.sh
```

Expected output:
```
✅ Docker is available and running.
✅ Kafka Docker image already exists
✅ Zookeeper Docker image already exists
✅ Kafka environment is ready!
📦 Starting Kafka using docker compose...
✅ Kafka started successfully!
📡 Brokers running on: localhost:9092
```

---

## Stop Kafka

```bash
./stop-kafka.sh
```

Expected output:
```
📦 Stopping Kafka using docker compose...
✅ Kafka and Zookeeper stopped successfully!
```

---

## Status

```bash
./status-kafka.sh
```

Output:
```
✅ Kafka container is running: kafka
✅ Zookeeper container is running: zookeeper
```

---

## Utilities

- `util/docker/docker-setup.sh` → Checks Docker installation & daemon.  
- `util/kafka/kafka-setup.sh` → Pulls Kafka & Zookeeper images if not present.

