```
docker build -t genghuiluo/otter-manager:4.2.14 --rm=true .

docker run -d --name manager-test -e IP=127.0.0.1 -e PORT=8080 -e ZK_CLUSTER=127.0.0.1:2181 -p 8080:8080 genghuiluo/otter-manager:4.2.14

```
