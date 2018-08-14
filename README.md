## my-dockerHub collection

> https://hub.docker.com/search/?q=genghuiluo

### [Download Docker engine & Search Docker image](https://store.docker.com/)

1. [Docker CE vs Docker EE](https://docs.docker.com/install/overview/)
2. [Install using repository](https://docs.docker.com/install/linux/docker-ce/centos/#install-using-the-repository) vs Install from a package


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
	docker save xxx_image_name:tags | gzip > ~/xxx-tags.tar.gz
	gzip -cd xxx-tags.tar.gz | docker load

	docker export xxx_container_name | gzip > ~/xxx.tar.gz
	gzip -cd xxx.tar.gz | docker import - xxx_image_name:tags # exported container & re-import as image
	```

	> [What is the difference between import and load in Docker?](https://stackoverflow.com/questions/36925261/what-is-the-difference-between-import-and-load-in-docker)

2. `docker rmi <your_name>/<image_name>:<tag>` remove a tag; `docker rmi <image_id>` remove a image
3. Dockerfile: [RUN vs CMD vs ENTRYPOINT?](http://goinbigdata.com/docker-run-vs-cmd-vs-entrypoint/)
4. To remove [dangling images](http://www.projectatomic.io/blog/2015/07/what-are-docker-none-none-images/): `docker images -f "dangling=true" -q|xargs docker rmi`
5. Get container IP: `docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' container_name_or_id`
6. utilize `docker logs` for debugging

