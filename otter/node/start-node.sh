#!/bin/bash -ex

# if ENV set
if [[ -z ${MANAGER+x} ]] || [[ -z ${NID+x} ]]; then
	echo 'unset ENV $MANAGER & $NID'
	exit 1
fi

echo $NID > /opt/otter-node/conf/nid

sed -i "s/manager_placeholder/$MANAGER/g" /opt/otter-node/conf/otter.properties

cd /opt/otter-node && (bash bin/startup.sh || (bash bin/stop.sh && bash bin/startup.sh)) && tail -f /opt/otter-node/logs/node/node.log
