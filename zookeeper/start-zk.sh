#!/bin/bash

# if ENV set
if [[ -z ${ZK_ID+x} ]]; then
	echo 'unset ENV $ZK_ID; will create a standalone cluster'
else
	echo $ZK_ID > /var/lib/zookeeper/myid
fi

cd /opt/zookeeper && ./bin/zkServer.sh start && tail -f zookeeper.out
