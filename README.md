# Kafka Toolbox

A lightweight **Kafka setup and management toolkit** using Docker. Ideal for **local development, testing, and learning Kafka** without consuming heavy system resources.

---

## Features

* Start/stop a **single-node Kafka + Zookeeper cluster** using Docker.
* Lightweight setup, optimized for laptops and development environments.
* Ready-to-use scripts for **starting, stopping, checking status, and cleaning Kafka**.
* Easily extendable to include Redpanda or embedded Kafka setups.
* Includes example Kafka topic creation for testing.

---

## Prerequisites

* Linux / macOS / Windows (with WSL2)
* Docker installed
* Docker Compose installed
* Minimum 2GB free RAM recommended

---

## Repository Structure

```
kafka-toolbox/
├── docker-compose.yml        # Docker Compose config for Kafka + Zookeeper
├── kafka-start.sh            # Script to start Kafka cluster
├── kafka-stop.sh             # Script to stop Kafka cluster
├── kafka-status.sh           # Script to check running containers and topics
├── kafka-clean.sh            # Script to remove all containers, volumes, logs
└── README.md                 # This file
```

---

## Setup Instructions

### 1. Clone the Repository

```bash
git clone https://github.com/<your-username>/kafka-toolbox.git
cd kafka-toolbox
```

### 2. Make Scripts Executable

```bash
chmod +x *.sh
```

### 3. Start Kafka Cluster

```bash
./kafka-start.sh
```

* Starts **Zookeeper** and **Kafka broker** in Docker containers.
* Verify with:

```bash
./kafka-status.sh
```

### 4. Stop Kafka Cluster

```bash
./kafka-stop.sh
```

* Stops all running Kafka and Zookeeper containers.

### 5. Clean Up (Optional)

```bash
./kafka-clean.sh
```

* Removes containers, volumes, and logs completely.

---

## Usage Example

Create a test topic:

```bash
docker exec -it $(docker ps -qf "name=kafka") \
  kafka-topics.sh --create --topic test-topic \
  --bootstrap-server localhost:9092 --partitions 1 --replication-factor 1
```

List topics:

```bash
docker exec -it $(docker ps -qf "name=kafka") \
  kafka-topics.sh --list --bootstrap-server localhost:9092
```

---

## Recommendations

* Limit Docker CPU/memory if running on a low-resource laptop:

```yaml
deploy:
  resources:
    limits:
      cpus: '1.0'
      memory: 1024M
```

* Stop the cluster when not in use to save resources.

---

## Contributing

* Feel free to extend this repo with **Redpanda**, **embedded Kafka**, or additional utility scripts.
* Pull requests and issues are welcome.

---

## License

MIT License © <Your Name>
