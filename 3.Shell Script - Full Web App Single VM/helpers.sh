#!/bin/bash

TARGET="localhost"
SSH_PORT="8322"
SSH_USER="admin"
SSH_KEY_FILE="files/private_ssh_key"
HTTP_PORT="8380"
OVA_FILE="files/4640_BASE.ova"
VM_NAME="4640_BOWEN_A00816145"

vbmg() {
	VBoxManage.exe "$@"
}

export -f vbmg
