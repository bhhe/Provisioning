#!/bin/bash

set -ux

install_dependencies() {
	dnf -y install git nginx
	dnf -y module install nodejs:14
}

create_user() {
	if id -u $1; then
		echo "User $1 exists"
		userdel -r $1
	fi
	
	useradd $1
}

setup_frontend() {
	sudo -u frontend git clone https://github.com/bezkoder/react-crud-web-api.git ~frontend/code
	npm install --prefix ~frontend/code
        cp http-common.js /home/frontend/code/src/
	npm run-script build --prefix ~frontend/code
	chmod a+rx ~frontend
}

setup_http_nginx() {
	firewall-cmd --add-service=http
	firewall-cmd --runtime-to-permanent

	cp nginx.conf /etc/nginx/nginx.conf
	
	sed -i 's/SELINUX=enforcing/SELINUX=permissive/g' /etc/sysconfig/selinux
	setenforce 0

	systemctl enable nginx
	systemctl start nginx
}

install_dependencies
create_user frontend
setup_frontend
setup_http_nginx
