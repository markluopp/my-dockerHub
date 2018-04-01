#!/bin/bash -ex

apt-get update
apt-get -y install expect

# use expect to set root password
MYSQL_ROOT_PASSWORD=abc123

expect <<EOF
set timeout 120
spawn apt-get -y install mysql-server
expect {
	"New password for *" {
		send "$MYSQL_ROOT_PASSWORD\r"
		expect {
			"Repeat password for *" {
				send "$MYSQL_ROOT_PASSWORD\r"
			}
		}
	}
}
expect eof
EOF

service mysql start

mysql -u root -pabc123 -e "set global sql_mode='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';"
mysql -u root -pabc123 < /opt/otter-manager-schema.sql

service mysql stop

apt-get -y purge expect
