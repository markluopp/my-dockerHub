## Nginx

> docker hub: https://hub.docker.com/\_/nginx/

```
docker run --name nginx-demo -v /absolute/path/hello-nginx:/usr/share/nginx/html:ro -p 80:80 -d nginx
# :ro is ready-only, read-write is default mode

# port mapping
docker run --name nginx-demo -p 8080:80 -v /absolute/path:/usr/share/nginx/html:ro -d nginx

# nginx.conf
docker run --name nginx-demo -p 8080:80 -v /absolute/path:/usr/share/nginx/html:ro -v /host/path/nginx.conf:/etc/nginx/nginx.conf:ro -d nginx
```
