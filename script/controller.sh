NODE_ID=${HOSTNAME:11}
REFERENCE_CONF=/opt/kafka/conf/controller.conf
MODIFIED_CONF=/opt/kafka/conf/controller-modified.conf
sed "s/node.id=.*/node.id=$NODE_ID/" $REFERENCE_CONF > $MODIFIED_CONF
/usr/local/kafka/bin/kafka-storage.sh format -t $CLUSTER_ID -c $MODIFIED_CONF
/usr/local/kafka/bin/kafka-server-start.sh $MODIFIED_CONF