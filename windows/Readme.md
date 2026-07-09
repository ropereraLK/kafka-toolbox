Let's create your first topic.

Run:

docker exec broker1 /opt/kafka/bin/kafka-topics.sh `
  --bootstrap-server broker1:9092 `
  --create `
  --topic payment-events `
  --partitions 4 `
  --replication-factor 3

Then describe it:

docker exec broker1 /opt/kafka/bin/kafka-topics.sh `
  --bootstrap-server broker1:9092 `
  --describe `
  --topic payment-events