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

# Download Kafka.
RUN set -x \
  && wget https://downloads.apache.org/kafka/3.2.1/kafka_2.13-3.2.1.tgz --quiet

# Install Kafka.
RUN set -x \
  && tar xvzf kafka_2.13-3.2.1.tgz > /dev/null \
  && cp -r kafka_2.13-3.2.1/* /usr/local/lib/kafka/ \
  && chown -R kafka:kafka /usr/local/lib/kafka \
  && rm -rf kafka_2.13-3.2.1.tgz kafka_2.13-3.2.1
RUN set -x \
  && mkdir /opt/kafka \
  && mkdir /opt/kafka/data \
  && mkdir /opt/kafka/log \
  && mkdir /opt/kafka/conf \
  && mkdir /opt/kafka/script \
  && touch /opt/kafka/system \
  && chown -R kafka:kafka /opt/kafka

# Switch work directory.
WORKDIR /
