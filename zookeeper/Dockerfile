FROM genghuiluo/my-ubuntu:16.04

ARG download_jdk=jdk-8u161-linux-x64.tar.gz
ARG download_zk=zookeeper-3.4.10.tar.gz

# add JDK
COPY $download_jdk /opt/ 
RUN mkdir /opt/jdk && tar -zxf /opt/$download_jdk -C /opt/jdk --strip-components 1
#RUN tar -zxf /opt/jdk-8u151-linux-x64.tar.gz -C /opt
ENV PATH="/opt/jdk/bin:${PATH}"

# add zookeeper
COPY $download_zk start-zk.sh /opt/
RUN mkdir /opt/zookeeper && tar -zxf /opt/$download_zk -C /opt/zookeeper --strip-components 1 && chmod +x /opt/start-zk.sh
#RUN tar -zxf /opt/zookeeper-3.4.10.tar.gz -C /opt && chmod +x /opt/start-zk.bash
COPY zoo.cfg /opt/zookeeper/conf/
RUN mkdir /var/lib/zookeeper && touch /var/lib/zookeeper/myid

# the zookeeper client port, follower port, election port
EXPOSE 2181 2888 3888 
CMD ["/opt/start-zk.sh"]
