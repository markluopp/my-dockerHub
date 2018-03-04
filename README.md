## my-dockerHub collection

> https://hub.docker.com/search/?q=genghuiluo

### [Download Docker engine.](https://store.docker.com/)

### [Dockerfile reference.](https://docs.docker.com/engine/reference/builder/#usage)

### [Get started with Docker.](https://docs.docker.com/get-started/)

Here is a list of the basic commands from this page, and some related ones if you’d like to explore a bit before moving on.
```
docker build -t friendlyname .  # Create image using this directory's Dockerfile
docker run -p 4000:80 friendlyname  # Run "friendlyname" mapping port 4000 to 80
docker run -d -p 4000:80 friendlyname         # Same thing, but in detached mode
docker ps                                 # See a list of all running containers
docker stop <hash>                     # Gracefully stop the specified container
docker ps -a           # See a list of all containers, even the ones not running
docker kill <hash>                   # Force shutdown of the specified container
docker rm <hash>              # Remove the specified container from this machine
docker rm $(docker ps -a -q)           # Remove all containers from this machine
docker images -a                               # Show all images on this machine
docker rmi <imagename>            # Remove the specified image from this machine
docker rmi $(docker images -q)             # Remove all images from this machine
docker login             # Log in this CLI session using your Docker credentials
docker tag <image> username/repository:tag  # Tag <image> for upload to registry
docker push username/repository:tag            # Upload tagged image to registry
docker run username/repository:tag                   # Run image from a registry
```

### Q & A

1. How to copy docker images from one host to another without via repository?

	utilize `docker save & load` for image and `docker export & import` for container
	```
	docker save otter-manager:1.0 | gzip > ~/otter-manager-1.0.tar.gz
	gzip -cd otter-manager-1.0.tar.gz | docker load
	```

2. `docker rmi <your_name>/<image_name>:<tag>` remove a tag `docker rmi <image_id>` remove a image
