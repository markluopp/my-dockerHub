```
docker build -t genghuiluo/otter-node:4.2.14 --rm=true .

docker run -d --name otter-node2 -e MANAGER=172.17.0.6:1099 -e NID=2 genghuiluo/otter-node:4.2.14
```
