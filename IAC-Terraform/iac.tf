
provider "aws" {
  region = "us-east-1"
}


# Get default VPC
data "aws_vpc" "default" {
  default = true
}

# Security Group to allow SSH access
resource "aws_security_group" "ssh_access" {
  name        = "allow-ssh"
  description = "Allow SSH inbound traffic"
  vpc_id      = data.aws_vpc.default.id

  # Allow SSH
  ingress {
    description = "SSH from anywhere"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow HTTP
  ingress {
    description = "HTTP from anywhere"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow-ssh"
  }
}



# First Server - Control Server
resource "aws_instance" "control-server" {
  ami = "ami-08982f1c5bf93d976"
  instance_type = "t2.micro"
  key_name = "ansible-101"
  vpc_security_group_ids = [ aws_security_group.ssh_access.id ]
  
  tags = {
    Name = "Ansible-Control-Server"
  }
}


# Second Server - Managed Server 1
resource "aws_instance" "managed-server-1" {
  ami = "ami-08982f1c5bf93d976"
  instance_type = "t2.micro"
  key_name = "ansible-101"
  vpc_security_group_ids = [ aws_security_group.ssh_access.id ]
  
  tags = {
    Name = "Ansible-Managed-Server-1"
  }
}



# Third Server - Managed Server 2
resource "aws_instance" "managed-server-2" {
  ami = "ami-08982f1c5bf93d976"
  instance_type = "t2.micro"
  key_name = "ansible-101"
  vpc_security_group_ids = [ aws_security_group.ssh_access.id ]
  
  tags = {
    Name = "Ansible-Managed-Server-2"
  }
}


output "server_ips" {
  value = {
    control_server   = aws_instance.control-server.public_ip
    managed_server_1 = aws_instance.managed-server-1.public_ip
    managed_server_2 = aws_instance.managed-server-2.public_ip
  }
}

