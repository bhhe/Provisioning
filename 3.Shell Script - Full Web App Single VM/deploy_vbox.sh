#!/bin/bash

set -xu

source helpers.sh

scp_vm() {
	scp -i ${SSH_KEY_FILE} -P ${SSH_PORT} \
	    -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null \
	    "$1" ${SSH_USER}@${TARGET}:
}

ssh_vm() {
	ssh -i ${SSH_KEY_FILE} -p ${SSH_PORT} \
	    -o ConnectTimeout=1 -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null \
	    ${SSH_USER}@${TARGET} "$@"
}

wait_for_ssh() {
	while /bin/true; do
		ssh_vm exit
		if [ $? -eq 0 ]; then
			echo "The virtual machine is up!"
			break
		else
			sleep 2
		fi
	done
}

provision_vbox() {
	vbmg list vms | grep ${VM_NAME}
	if [ $? -eq 0 ]; then
		vbmg controlvm ${VM_NAME} poweroff
		sleep 1
		vbmg unregistervm ${VM_NAME} --delete
	fi

	vbmg import ${OVA_FILE} --vsys 0 --vmname ${VM_NAME} --cpus 2
	vbmg modifyvm ${VM_NAME} --natpf1 "ssh,tcp,,${SSH_PORT},,22"
	vbmg modifyvm ${VM_NAME} --natpf1 "http,tcp,,${HTTP_PORT},,80"
	vbmg startvm ${VM_NAME}


}

deploy_app() {
	scp_vm files/nginx.conf 
	scp_vm deploy_vm.sh
	scp_vm files/frontend/http-common.js
	scp_vm files/backend/db_init.sql
	scp_vm files/backend/db.config.js
	scp_vm files/backend/backend.service	
	ssh_vm bash deploy_vm.sh
}

provision_vbox
wait_for_ssh
deploy_app
