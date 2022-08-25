#!/bin/bash

NODE_ID=$(( 1000 + ${HOSTNAME:7} ))
SERVER_REFERENCE_CONF=/opt/kafka/conf/server-reference.conf
SERVER_CONF=/opt/kafka/conf/server.conf
sed "s/node.id=.*/node.id=$NODE_ID/" $SERVER_REFERENCE_CONF > $SERVER_CONF
/usr/local/lib/kafka/bin/kafka-storage.sh format -t $CLUSTER_ID -c $SERVER_CONF
/usr/local/lib/kafka/bin/kafka-server-start.sh $SERVER_CONF
