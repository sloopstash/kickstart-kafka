NODE_ID=$(( 1000 + ${HOSTNAME:7} ))
REFERENCE_CONF=/opt/kafka/conf/broker.conf
MODIFIED_CONF=/opt/kafka/conf/broker-modified.conf
sed "s/node.id=.*/node.id=$NODE_ID/" $REFERENCE_CONF > $MODIFIED_CONF
/usr/local/kafka/bin/kafka-storage.sh format -t $CLUSTER_ID -c $MODIFIED_CONF
/usr/local/kafka/bin/kafka-server-start.sh $MODIFIED_CONF