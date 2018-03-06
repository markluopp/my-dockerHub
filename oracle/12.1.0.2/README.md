
``` bash
# build docker image
./buildDockerImage.sh -v 12.1.0.2 -e

# create docker container (-d for detach)
docker run -d --name oracle_12cr1_ee \
-p 1521:1521 -p 5500:5500 \
-e ORACLE_SID=orcl_dev -e ORACLE_PDB=pdb_mark -e ORACLE_PWD=1234 \
-v /opt/oracle_data:/opt/oracle/oradata \
genghuiluo/oracle:12.2.0.1-ee

# Notice: /opt/oracle_data should be 777 rwxrwxrwx
```
