#!/bin/bash

set -ux

install_dependencies() {
	dnf -y install git
	dnf -y module install nodejs:14
}

create_user() {
	if id -u $1; then
		echo "User $1 exists"
		userdel -r $1
	fi
	
	useradd $1
}

setup_backend() {
	firewall-cmd --add-port=8080/tcp
	firewall-cmd --runtime-to-permanent
	sudo -u backend git clone https://github.com/bezkoder/nodejs-express-sequelize-mysql.git ~backend/code
	npm install --prefix ~backend/code
	cp db.config.js ~backend/code/app/config/
}

setup_backend_service() {
	cp backend.service /etc/systemd/system/backend.service
        systemctl daemon-reload
	systemctl enable backend.service
	systemctl start backend.service
}
install_dependencies
create_user backend
setup_backend
setup_backend_service
