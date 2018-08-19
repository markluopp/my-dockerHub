- To build image: `docker build -t genghuiluo/my-ubuntu:16.04`
- To create container: 
  1. temporarily, `docker run -it --rm genghuiluo/my-ubuntu:16.04`
  2. at background, `docker run -dit --name your_container_name genghuiluo/my-ubuntu:16.04` && `docker exec -it your_container_name /bin/bash`
