FROM genghuiluo/my-ubuntu:16.04

ARG download_jdk=jdk-8u161-linux-x64.tar.gz
ARG download_manager=manager.deployer-4.2.14.tar.gz

# copy downloaded
COPY $download_jdk $download_manager start-manager.sh initialize_mysql.sh otter-manager-schema.sql /opt/ 

# install MySQL
RUN chmod +x /opt/initialize_mysql.sh 
RUN /opt/initialize_mysql.sh

# add JDK
RUN mkdir /opt/jdk && tar -zxf /opt/$download_jdk -C /opt/jdk --strip-components 1
ENV PATH="/opt/jdk/bin:${PATH}"

# add otter-manager
RUN mkdir /opt/otter-manager && tar -zxf /opt/$download_manager -C /opt/otter-manager

# add script & otter.properties
COPY otter.properties /opt/otter-manager/conf
RUN chmod +x /opt/start-manager.sh
WORKDIR /opt/otter-manager

# 8080 is web console, 1099 use for connecting manager from node
EXPOSE 8080 1099
CMD ["/opt/start-manager.sh"]
