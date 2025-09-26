# Ansible-Crash-Course

Learn Ansible fundamentals in this concise tutorial! We cover Playbooks, Ad-hoc Commands, Variables, Ansible Vault, Tags, and Tag Names with clear examples. Perfect for beginners looking to master automation!

## Infrastructure As Code With Terraform

```bash
cd IAC-Terraform

terraform init

terraform validate

terraform plan

terraform apply

# At The End you must destroy all infra not to consume you
terraform destroy
```

## Configuring Ansible on Control Instance and 2 Managed Instances We have created

```bash
# Go To your AWS Accout and Login 
# Then Go To EC2 Instaces and Connect To Each One (ALL Servers) We have beed created

chmod 400 "ansible-101.pem"

ssh -i "ansible-101.pem" ec2-user@ec2-54-242-169-239.compute-1.amazonaws.com
```

```bash
## After Login Let's Configure The 3 Server Together ->

# Create a new user for ansible
sudo useradd ansible

# Create a new password for ansible
sudo passwd ansible

# change so configuration in visudo file
sudo visude
# then add ==> ansible ALL=(ALL) NOPASSWD: ALL

# change so configuration in sshd_config file
sudo vi /etc/ssh/sshd_config
# then change ==> PasswordAuthentication no -to-> yes
# then change ==> PermitEmptyPasswords no -to-> yes

# Restart sshd Service
sudo service sshd restart
```

```bash
## Then Only on Control Server Run the Following

# Install Python
sudo yum install python3 -y

# check Python Version
python3 --version

# Install PIP Package Manager
sudo yum install python3-pip -y

# Now Install Ansible With pip3
pip3 install ansible --user

# check Ansible Version
ansible --version

# Create a ew directory in /etc called ansible
sudo mkdir /etc/ansible

## Create an SSH-Key and then Copy it To All Managed Nodes

sudo su ansible

ssh-keygen # Then Press Enter keep it default or as you need

# Let's Copy SSH-Key To ALL Managed Servers
ssh-copy-id ansible@<private-ip-address-of-servet> # Repeat it For All Managed Servers
```

```bash
## Add Now All Host (Nothing but the private ip addres for each machine)
sudo vi /etc/ansible/hosts

## then write
[webservers]
<private-ip-address>
[dbservers]
<private-ip-address>

## Test Them Now With Some Ad-Hoc Commands ??

ansible all -m ping # ansible webservers -m ping

ansible all -m shell -a date

ansible all -m uptime
```

```bash
## Let's Start Our First Ansible Playbook

sudo su ansible

cd ansible

vi first-playbook.yml  # Then Paste the Configuration

ansible-playbook first-playbook.yml --syntax-check

ansible-playbook first-playbook.yml

ansible-playbook file-creation.yaml --list-host
```

```bash
## How Create Files From Control Server onto Mangaed One's With Ansible Playbook

sudo su ansible

cd ansible

vi file-creation.yaml # Then Paste the Configuration

ansible-playbook file-creation.yaml --syntax-check

ansible-playbook file-creation.yaml 
# After That Command Go To The Managed Servers and Check You Will Find shwa.txt file

ansible-playbook file-creation.yaml --list-host
```

```bash
## Let's Install Git From Control Server To All Managed Servers

sudo su ansible

cd ansible

vi git-install.yml # Then Paste the Configuration

ansible-playbook git-install.yml --syntax-check

ansible-playbook git-install.yml 

ansible-playbook git-install.yml --list-host
```

```bash
## Let's Install Git From Control Server To All Managed Servers

sudo su ansible

cd ansible

vi maven-java-install.yml # Then Paste the Configuration

ansible-playbook maven-java-install.yml --syntax-check

ansible-playbook maven-java-install.yml 

ansible-playbook maven-java-install.yml --list-host
```
