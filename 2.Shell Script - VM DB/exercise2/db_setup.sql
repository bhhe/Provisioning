CREATE DATABASE assignment;
CREATE USER acit4640 IDENTIFIED BY 'P@ssw0rd';
GRANT ALL PRIVILEGES ON assignment.* TO acit4640@'%';
FLUSH PRIVILEGES;
USE assignment;
CREATE TABLE IF NOT EXISTS students(name VARCHAR(225) NOT NULL, student_id VARCHAR(9) NOT NULL, PRIMARY KEY(student_id));
INSERT INTO students (student_id, name) VALUES ("A00816145", "Bowen");
