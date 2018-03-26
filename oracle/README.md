> ref: https://github.com/oracle/docker-images/tree/master/OracleDatabase

# Oracle Database on Docker
Sample Docker build files to facilitate installation, configuration, and environment setup for DevOps users. For more information about Oracle Database please see the [Oracle Database Online Documentation](http://docs.oracle.com/database/121/index.htm).

## How to build and run
This project offers sample Dockerfiles for:
 * Oracle Database 12c Release 2 (12.2.0.1) Enterprise Edition and Standard Edition 2
 * Oracle Database 12c Release 1 (12.1.0.2) Enterprise Edition and Standard Edition 2
 * Oracle Database 11g Release 2 (11.2.0.2) Express Edition.

To assist in building the images, you can use the [buildDockerImage.sh](dockerfiles/buildDockerImage.sh) script. See below for instructions and usage.

The `buildDockerImage.sh` script is just a utility shell script that performs MD5 checks and is an easy way for beginners to get started. Expert users are welcome to directly call `docker build` with their prefered set of parameters.

### Building Oracle Database Docker Install Images
**IMPORTANT:** You will have to provide the installation binaries of Oracle Database and put them into the `dockerfiles/<version>` folder. You only need to provide the binaries for the edition you are going to install. The binaries can be downloaded from the [Oracle Technology Network](http://www.oracle.com/technetwork/database/enterprise-edition/downloads/index.html). You also have to make sure to have internet connectivity for yum. Note that you must not uncompress the binaries. The script will handle that for you and fail if you uncompress them manually!

Before you build the image make sure that you have provided the installation binaries and put them into the right folder. Once you have chosen which edition and version you want to build an image of, go into the **dockerfiles** folder and run the **buildDockerImage.sh** script:

    [oracle@localhost dockerfiles]$ ./buildDockerImage.sh -h
    
    Usage: buildDockerImage.sh -v [version] [-e | -s | -x] [-i] [-o] [Docker build option]
    Builds a Docker Image for Oracle Database.
    
    Parameters:
       -v: version to build
           Choose one of: 11.2.0.2  12.1.0.2  12.2.0.1
       -e: creates image based on 'Enterprise Edition'
       -s: creates image based on 'Standard Edition 2'
       -x: creates image based on 'Express Edition'
       -i: ignores the MD5 checksums
       -o: passes on Docker build option
    
    * select one edition only: -e, -s, or -x
    

**IMPORTANT:** The resulting images will be an image with the Oracle binaries installed. On first startup of the container a new database will be created, the following lines highlight when the database is ready to be used:

	#########################
	DATABASE IS READY TO USE!
	#########################

You may extend the image with your own Dockerfile and create the users and tablespaces that you may need.

The character set for the database is set during creating of the database. 11g Express Edition supports only UTF-8. You can set the character set for the Standard Edition 2 and Enterprise Edition during the first run of your container and may keep separate folders containing different tablespaces with different character sets.

### Running Oracle Database in a Docker container

#### Running Oracle Database Enterprise and Standard Edition 2 in a Docker container
To run your Oracle Database Docker image use the **docker run** command as follows:

	docker run --name <container name> \
	-p <host port>:1521 -p <host port>:5500 \
	-e ORACLE_SID=<your SID> \
	-e ORACLE_PDB=<your PDB name> \
	-e ORACLE_PWD=<your database passwords> \
	-e ORACLE_CHARACTERSET=<your character set> \
	-v [<host mount point>:]/opt/oracle/oradata \
	oracle/database:12.2.0.1-ee
	
	Parameters:
	   --name:        The name of the container (default: auto generated)
	   -p:            The port mapping of the host port to the container port. 
	                  Two ports are exposed: 1521 (Oracle Listener), 5500 (OEM Express)
	   -e ORACLE_SID: The Oracle Database SID that should be used (default: ORCLCDB)
	   -e ORACLE_PDB: The Oracle Database PDB name that should be used (default: ORCLPDB1)
	   -e ORACLE_PWD: The Oracle Database SYS, SYSTEM and PDB_ADMIN password (default: auto generated)
	   -e ORACLE_CHARACTERSET:
	                  The character set to use when creating the database (default: AL32UTF8)
	   -v /opt/oracle/oradata
	                  The data volume to use for the database.
	                  Has to be writable by the Unix "oracle" (uid: 54321) user inside the container!
	                  If omitted the database will not be persisted over container recreation.
	   -v /opt/oracle/scripts/startup | /docker-entrypoint-initdb.d/startup
	                  Optional: A volume with custom scripts to be run after database startup.
	                  For further details see the "Running scripts after setup and on startup" section below.
	   -v /opt/oracle/scripts/setup | /docker-entrypoint-initdb.d/setup
	                  Optional: A volume with custom scripts to be run after database setup.
	                  For further details see the "Running scripts after setup and on startup" section below.

Once the container has been started and the database created you can connect to it just like to any other database:

	sqlplus sys/<your password>@//localhost:1521/<your SID> as sysdba
	sqlplus system/<your password>@//localhost:1521/<your SID>
	sqlplus pdbadmin/<your password>@//localhost:1521/<Your PDB name>

The Oracle Database inside the container also has Oracle Enterprise Manager Express configured. To access OEM Express, start your browser and follow the URL:

	https://localhost:5500/em/

**NOTE**: Oracle Database bypasses file system level caching for some of the files by using the `O_DIRECT` flag. It is not advised to run the container on a file system that does not support the `O_DIRECT` flag.

#### Changing the admin accounts passwords

On the first startup of the container a random password will be generated for the database if not provided. You can find this password in the output line:  
	
	ORACLE PASSWORD FOR SYS, SYSTEM AND PDBADMIN:

The password for those accounts can be changed via the **docker exec** command. **Note**, the container has to be running:

	docker exec <container name> ./setPassword.sh <your password>

#### Running Oracle Database Express Edition in a Docker container
To run your Oracle Database Express Edition Docker image use the **docker run** command as follows:

	docker run --name <container name> \
	--shm-size=1g \
	-p 1521:1521 -p 8080:8080 \
	-e ORACLE_PWD=<your database passwords> \
	-v [<host mount point>:]/u01/app/oracle/oradata \
	oracle/database:11.2.0.2-xe
	
	Parameters:
	   --name:        The name of the container (default: auto generated)
	   --shm-size:    Amount of Linux shared memory
	   -p:            The port mapping of the host port to the container port.
	                  Two ports are exposed: 1521 (Oracle Listener), 8080 (APEX)
	   -e ORACLE_PWD: The Oracle Database SYS, SYSTEM and PDB_ADMIN password (default: auto generated)

	   -v /u01/app/oracle/oradata
	                  The data volume to use for the database.
	                  Has to be writable by the Unix "oracle" (uid: 54321) user inside the container!
	                  If omitted the database will not be persisted over container recreation.
	   -v /u01/app/oracle/scripts/startup | /docker-entrypoint-initdb.d
	                  Optional: A volume with custom scripts to be run after database startup.
	                  For further details see the "Running scripts after setup and on startup" section below.
	   -v /u01/app/oracle/scripts/setup | /docker-entrypoint-initdb.d
	                  Optional: A volume with custom scripts to be run after database startup.
	                  For further details see the "Running scripts after setup and on startup" section below.

There are two ports that are exposed in this image:
* 1521 which is the port to connect to the Oracle Database.
* 8080 which is the port of Oracle Application Express (APEX).

On the first startup of the container a random password will be generated for the database if not provided. You can find this password in the output line:

	ORACLE PASSWORD FOR SYS AND SYSTEM:

**Note:** The ORACLE_SID for Express Edition is always `XE` and cannot be changed, hence there is no ORACLE_SID parameter provided for the XE build.

The password for those accounts can be changed via the **docker exec** command. **Note**, the container has to be running:
	docker exec oraclexe /u01/app/oracle/setPassword.sh <your password>

Once the container has been started you can connect to it just like to any other database:

	sqlplus sys/<your password>@//localhost:1521/XE as sysdba
	sqlplus system/<your password>@//localhost:1521/XE
