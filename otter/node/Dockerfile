FROM genghuiluo/my-ubuntu:16.04

ARG download_jdk=jdk-8u161-linux-x64.tar.gz
ARG download_node=node.deployer-4.2.14.tar.gz
ARG download_aria2c=aria2-1.33.1.tar.gz

# copy downloaded
COPY $download_jdk $download_node $download_aria2c start-node.sh /opt/ 

# add JDK
RUN mkdir /opt/jdk && tar -zxf /opt/$download_jdk -C /opt/jdk --strip-components 1
ENV PATH="/opt/jdk/bin:${PATH}"

# add otter-node
RUN mkdir /opt/otter-node && tar -zxf /opt/$download_node -C /opt/otter-node
RUN touch /opt/otter-node/conf/nid

# install aria2c
RUN mkdir /opt/aria2c && tar -zxf /opt/$download_aria2c -C /opt/aria2c --strip-components 1
WORKDIR /opt/aria2c
# https://github.com/aria2/aria2
RUN ./configure && make && make install

# add otter.properties
COPY otter.properties /opt/otter-node/conf
RUN chmod +x /opt/start-node.sh
WORKDIR /opt/otter-node

# 2088 communication port, 9090 download port
EXPOSE 2088 9090 
CMD ["/opt/start-node.sh"]
