#!/bin/bash

set -ux

install_dependencies() {
	sudo dnf -y install git nginx
	sudo dnf -y module install nodejs:14
	sudo dnf -y install mysql-server
}

create_user() {
	if id -u $1; then
		echo "User $1 exists"
		sudo userdel -r $1
	fi
	
	sudo useradd $1
}

setup_frontend() {
	sudo -u frontend git clone https://github.com/bezkoder/react-crud-web-api.git ~frontend/code
	sudo -u frontend npm install --prefix ~frontend/code
	sudo cp http-common.js /home/frontend/code/src/
	sudo -u frontend npm run-script build --prefix ~frontend/code
	sudo -u frontend chmod a+rx ~frontend
}

setup_backend() {
	sudo -u backend git clone https://github.com/bezkoder/nodejs-express-sequelize-mysql.git ~backend/code
	sudo -u backend npm install --prefix ~backend/code
	setup_mysql
	sudo cp db.config.js ~backend/code/app/config/
	setup_backend_service
}

setup_mysql() {
	sudo systemctl enable mysqld
	sudo systemctl start mysqld
	sudo mysql -u root < db_init.sql
}

setup_http_nginx() {
	sudo firewall-cmd --add-service=http
	sudo firewall-cmd --runtime-to-permanent

	sudo cp nginx.conf /etc/nginx/nginx.conf
	
	sudo sed -i 's/SELINUX=enforcing/SELINUX=permissive/g' /etc/sysconfig/selinux
	sudo setenforce 0

	sudo systemctl enable nginx
	sudo systemctl start nginx
}

setup_backend_service() {
	sudo cp backend.service /etc/systemd/system/backend.service
	sudo systemctl daemon-reload
	sudo systemctl enable backend.service
	sudo systemctl start backend.service
}

install_dependencies
create_user frontend
create_user backend
setup_frontend
setup_backend
setup_http_nginx
