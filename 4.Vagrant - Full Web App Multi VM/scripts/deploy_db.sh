#!/bin/bash

set -ux

install_dependencies() {
	dnf -y install mysql-server
}

setup_db() {
	firewall-cmd --add-port=3306/tcp
	firewall-cmd --runtime-to-permanent
	setup_mysql
}

setup_mysql() {
	systemctl enable mysqld
	systemctl start mysqld
	mysql -u root < db_init.sql
}

install_dependencies
setup_db
