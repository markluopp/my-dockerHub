### cloudera enterprise hadoop cluster

1. [cloudera quickstart docker image (pseudo-distributed configuration)](https://hub.docker.com/r/cloudera/quickstart/)

	```
	docker run --hostname=quickstart.cloudera \
	--privileged=true -t -i [OPTIONS] \
	cloudera/quickstart:latest /usr/bin/docker-quickstart

	# optional options:
	-p 7180:7180 (CM)
	-p 8888:8888 (Hue)
	-d (runs the container in the background)

	# Cloudera Manager is not started by default. To see options for starting it, run: /home/cloudera/cloudera-manager [--express]
	```

2. [forked: cloudera offical CDH cluster docker image](https://github.com/2L-knowledgebase/clusterdock)

	```
	# pre-define functions
	source clusterdock.sh

	# start  
	clusterdock_run ./bin/start_cluster cdh \
	--primary-node=node-1 --secondary-nodes='node-{2..4}' \	
	--include-service-types=HDFS,ZOOKEEPER,HBASE,YARN

	# SSH directly to nodes of your cluster 
	clusterdock_ssh node-1.cluster

	# auto add items /etc/hosts
	```
