> [ref: 分布式学习(1) ---- 初识Zookeeper](https://zhuanlan.zhihu.com/p/24996631)

zookeeper与分布式有着千丝万缕的联系。它虽然源自于hadoop，但目前zookeeper脱离hadoop的范畴开发分布式应用越来越普遍

**简单来说，zookeeper = 通知机制 + 文件系统**

#### 通知机制
相当于上面那个例子，客户端注册监听它关心的目录节点，当目录节点发生变化，如数据改变、被删除、子目录节点增加删除时，zookeeper会通知客户端。 这时客户端就可以根据传过来的信息采取一系列的操作

#### 文件系统
zookeeper维护一个如下图的文件结构

![](https://pic3.zhimg.com/80/v2-509835693be5bee29463fd4f5ba46de1_hd.jpg)




[zookeeper理解](https://zhuanlan.zhihu.com/p/31440592)
https://zookeeper.apache.org/

https://hub.docker.com/_/zookeeper/
https://github.com/31z4/zookeeper-docker

http://goinbigdata.com/docker-run-vs-cmd-vs-entrypoint/

https://hub.docker.com/r/oracle/openjdk/

https://github.com/docker-library/openjdk/blob/1506887e16eba85b37dcf0a5ff8c9c2abe3fa9b7/8-jdk/Dockerfile

