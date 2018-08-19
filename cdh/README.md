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

	# Cloudera Manager is not started by default. To see options for starting it, run cmd below inside container
	/home/cloudera/cloudera-manager [--express]
	
	access CM via http://<container/host_ip>:7180

	Username: cloudera
	Password: cloudera
	
	# cm service
	service cloudera-scm-server status
	service cloudera-scm-agent hard_stop_confirmed
	service cloudera-scm-agent clean_start
	
	# 主机的 NTP 服务未响应时钟偏差请求
	cp -f /usr/share/zoneinfo/Asia/Shanghai  /etc/localtime
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
