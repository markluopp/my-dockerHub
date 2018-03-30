## tensorflow

> docker hub: https://hub.docker.com/r/tensorflow/tensorflow/

```
# this is python2 version
docker pull tensorflow/tensorflow

# only cpu
docker run -d --name tf-demo -p 8888:8888  tensorflow/tensorflow

docker logs tf-demo

Copy/paste this URL into your browser when you connect for the first time,
to login with a token:
	http://localhost:8888/?token=0968781a7dfe210f8bf28911a33c54f9a632af7ce45a2e9d

docker cp hello-tf.py tf-demo:/notebooks/

docker exec -it tf-demo /bin/bash
```

