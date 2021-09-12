set -e
SSH='ssh -i VBOX_KEY -p 8222 admin@localhost'
dldir="/html"
$SSH sudo dnf -y install nginx
scp -i VBOX_KEY -P 8222 index.html admin@localhost:.
scp -i VBOX_KEY -P 8222 nginx.conf admin@localhost:.
[ ! -d "/html" ] && sudo mkdir -p "/html" && echo "Creating /html" || echo "Trying to create /html but already exists"
$SSH sudo chown -R admin:admin /html && echo "Granting admin priv to /html"
$SSH sudo mv index.html /html && echo "moving index.html to /html"
$SSH sudo mv nginx.conf /etc/nginx/nginx.conf && echo "Moving nginx.conf to etc/nginx"
$SSH sudo firewall-cmd --add-service=http && echo "Enabling http service for nginx"
$SSH sudo systemctl restart nginx && echo "Restarting nginx"
$SSH sudo systemctl enable nginx && echo "Enabling nginx"
