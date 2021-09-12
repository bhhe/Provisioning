set -e
TARGET="localhost"
SSH_PORT="8222"
USER="admin"
KEY_FILE="VBOX_KEY"
SSH="ssh -i ${KEY_FILE} -p ${SSH_PORT} ${USER}@${TARGET}"
$SSH sudo dnf -y install mysql-server && echo "Installing mysql-server"
$SSH sudo systemctl start mysqld && echo "Starting mysqld"
$SSH sudo systemctl enable mysqld && echo "Enabling mysqld on startup"
