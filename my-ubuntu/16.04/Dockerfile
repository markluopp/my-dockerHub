FROM ubuntu:16.04

# change to aliyun mirror if need
COPY sources.list /etc/apt/sources.list    
RUN apt-get update && \
apt-get upgrade -y && \
apt-get install build-essential -y && \
apt-get install software-properties-common -y && \
apt-get install file tzdata -y && \
apt-get install byobu curl git htop man unzip vim wget -y

# change timezone, e.g. UTC+8
# There is a bug (https://bugs.launchpad.net/ubuntu/+source/tzdata/+bug/1554806, 
# not fixed at the time of writing this answer) in 16.04 which causes the contents of /etc/timezone to be overwritten with the old value when running dpkg-reconfigure -f noninteractive tzdata.
RUN ln -fs /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && dpkg-reconfigure -f noninteractive tzdata

# .bashrc && .bash_profile
ADD .bashrc /root/.bashrc
ADD .bash_profile /root/.bash_profile

# Define default command
CMD ["bash"]
