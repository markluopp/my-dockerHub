#!/bin/bash -ex

# if ENV set
if [[ -z ${IP+x} ]] || [[ -z ${PORT+x} ]] || [[ -z ${ZK_CLUSTER+x} ]]; then
	echo 'unset ENV $IP & $PORT & $ZK_CLUSTER'
	exit 1
fi

# magic of https://gist.github.com/ljfranklin/4a28740fbdfd86b896529f70be254768
find /var/lib/mysql/mysql -exec touch -c -a {} + && service mysql start

sed -i "s/access_ip_placeholder/$IP/g" /opt/otter-manager/conf/otter.properties
sed -i "s/access_port_placeholder/$PORT/g" /opt/otter-manager/conf/otter.properties
sed -i "s/zookeeper_cluster_placeholder/$ZK_CLUSTER/g" /opt/otter-manager/conf/otter.properties

# docker start manager-test
# found otter.pid , Please run stop.sh first ,then startup.sh
cd /opt/otter-manager && (bash bin/startup.sh || (bash bin/stop.sh && bash bin/startup.sh)) && tail -f /opt/otter-manager/logs/manager.log
