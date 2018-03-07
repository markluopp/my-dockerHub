### MySQL docker image
> https://hub.docker.com/_/mysql/

```
docker pull mysql:8.0
docker run -d -p 127.0.0.1:9000:3306 --name mysql-server-8.0 -e MYSQL_ROOT_PASSWORD=xxx mysql:8.0
```

#### 1. [Connect to mysql in a docker container from the host](https://stackoverflow.com/questions/33001750/connect-to-mysql-in-a-docker-container-from-the-host)

If your Docker MySQL host is running correctly you can connect to it from local machine, but you should specify host, port and protocol like this:
```
mysql -h localhost -P 3306 --protocol=tcp -u root
```

- Change 3306 to port number you have forwarded from Docker container (in your case it will be 12345).
- Because you are running MySQL inside Docker container, **socket is not available and you need to connect through TCP**. Setting "--protocol" in the mysql command will change that.

#### 2. Using a custom MySQL configuration file

```
docker run --name some-mysql -v /my/custom:/etc/mysql/conf.d -e MYSQL_ROOT_PASSWORD=my-secret-pw -d mysql:tag
```

#### 3. Configuration without a cnf file

```
docker run --name some-mysql -e MYSQL_ROOT_PASSWORD=my-secret-pw -d mysql:tag --character-set-server=utf8mb4 --collation-server=utf8mb4_unicode_ci
```



### Mariadb docker image
> https://hub.docker.com/_/mariadb/

```
docker pull mariadb:10.3

docker run --name mariadb_10.3 -p 3306:3306 -v /data/mariadb_10.3:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=wOFKhED0wdI$ -d mariadb:10.3 --character-set-server=utf8mb4 --collation-server=utf8mb4_unicode_ci
```
