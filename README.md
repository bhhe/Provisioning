# Provisioning_Setups 
Provision fully functional web services with shell scripts, ansible to VMManagers or on Cloud(AWS)

# Concept
![image](https://user-images.githubusercontent.com/39607989/123719837-62f5aa00-d837-11eb-9c8a-85bd9fd73a77.png)

## Provisioning
Provisioning is a wide term that encompasses the configuration, deployment and management of IT systems. Provisioning usually refers to the concepts of “setting up” the hardware foundations that can be used by other systems (telecommunications, networks, storage).

Network provisioning  
Server provisioning  
User provisioning  

Example of provisioning tools:  
VBoxManage.exe  
Shell scripts  
Docker  
Amazon CloudFormation  

## Imaging  
A system image is a “copy” of the entire state of a computer system, usually stored as a file. System images allow administrators to create new systems without having to install the operating system manually every time.  

Examples of imaging tools:  

Open Virtualization Format  
VDI (VirtualBox Disk Image)  
Packer  
Amazon AMI  
Docker images  

## Configuration management and reporting  
Configuration management is the process of establishing and maintaining the consistency of the systems. It is an ongoing process - and can affect software installed, configuration files, execution of processes, and so on.  

Example of configuration management tools:  

Ansible  
Chef  
Puppet  

## Monitoring and reporting  
After a systems is setup, it is important to keep an eye on how it is being used and detect eventual errors. Reporting is usually associated with monitoring - giving insight on the “health” of the systems.  

Example of reporting tools:  

Nagios  
Amazon /vendors dashboard  

## Deployment  
The term is coming from the military and means “sending into duty troops (or equipment), and moving them to a specific location”. In IT terms, that means all the activities required to make a system available for use.  

Server deployment  
Software deployment  
Network deployment  
Operating system deployment  

## Infrastructure as code  
Using virtualized infrastructure, there is no need to physically interact with the hardware or the equipment in order to provision and deploy applications. The whole infrastructure can be managed as software (for instance, using version control) - which is the concept of infrastructure as code. Git is often used in this context.  

This has several benefits:  

limits the risk of errors  
speeds up the deployment of systems  
gives accountability and traceability in changes (who changed what, when?)  

# Commands

## SSH Commands
ssh-keygen -t rsa -b 4096 -a 100 -P "" -f THIS_IS_MY_PRIVATE_KEY_FILE  
ssh -i MY_PRIVATE_KEY_FILE -p 8222 admin@localhost  

## Linux Script Tips
-e //Script exits as soon as a command encounters an error  
-u //The script exits if a variable is not defined  
-x //Displays each script line before running it  

Variables
SETUP_FOLDER=/home/admin/setup  
${SETUP_FOLDER}  

## Sudo run as specific users
sudo -i  
su - user  

sudo -u user bash -c "cd app && npm install"  
or  
sudo -u user npm install --folder /home/user/app  

## Firewall Commands
firewall-cmd --list-all  
firewall-cmd --add-service=http  
firewall-cmd --add-port=80/tcp  
firewall-cmd --runtime-to-permanent  

## Virtual Box Commands
VBoxManage.exe modifyvm "VM name" --natpf1 "ssh,tcp,,8022,,22"  

## Vagrant Commands
Vagrant init -h  
Vagrant provision  
Vagrant reload --provision  
Vagrant up  
Vagrant halt  
Vagrant destroy  
Vagrant ssh  
Vagrant status  

## Ansible Commands
ansible-playbook playbook.yaml --tags aws  

ansible-galaxy role init nginx //Create folder nginx with necessary subfolders for new ansible role  

Setup variables in role/defaults/main.yml  
Designate tasks in role/tasks/main.yml  
