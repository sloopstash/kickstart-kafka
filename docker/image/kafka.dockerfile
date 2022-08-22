# Docker image to use.
FROM sloopstash/amazonlinux:v1

# Switch work directory.
WORKDIR /tmp

# Install Oracle JDK.
COPY jdk-8u131-linux-x64.rpm ./
RUN set -x \
  && rpm -Uvh jdk-8u131-linux-x64.rpm \
  && rm -rf jdk-8u131-linux-x64.rpm

# Create system user for Kafka.
RUN set -x \
  && useradd -m -s /bin/bash -d /usr/local/lib/kafka kafka

# Download and extract Kafka.
RUN set -x \
  && wget https://downloads.apache.org/kafka/3.2.1/kafka_2.13-3.2.1.tgz \
  && tar -xzf kafka_2.13-3.2.1.tgz \
  && mv kafka_2.13-3.2.1 /usr/local/kafka \
  && rm -r kafka_2.13-3.2.1*

# Create necessary directories.
RUN set -x \
  && mkdir -p /opt/kafka/conf \
  && mkdir -p /opt/kafka/log \
  && mkdir -p /opt/kafka/data \
  && mkdir -p /opt/kafka/script \
  && chown -R kafka:kafka /opt/kafka \
  && history -c

# Set default work directory.
WORKDIR /opt/kafka