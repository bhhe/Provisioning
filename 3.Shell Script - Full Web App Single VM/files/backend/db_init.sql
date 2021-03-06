DELETE FROM mysql.user where User='';
DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', ':1');
DROP DATABASE IF EXISTS test;
DELETE FROM mysql.db WHERE Db='test' OR db='test\\_%';
CREATE USER backend;
ALTER USER 'backend'@'%' IDENTIFIED BY 'P@ssw0rd';
CREATE DATABASE IF NOT EXISTS backend;
SHOW DATABASES;
GRANT ALL PRIVILEGES ON backend.* TO 'backend'@'%';
ALTER USER 'root'@'localhost' IDENTIFIED BY 'P@ssw0rd';
FLUSH PRIVILEGES;
