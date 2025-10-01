# instance creation
resource "aws_instance" "tool" {
  ami                       = data.aws_ami.rhel9.image_id
  instance_type             = var.instance_type
  vpc_security_group_ids    = [aws_security_group.tool-sg.id]
  iam_instance_profile      = aws_iam_instance_profile.main.name
  key_name                  = data.aws_key_pair.key.key_name

  user_data = <<-EOF
    #! /bin/bash

    # Update the System
    sudo dnf update -y
    sudo dnf upgrade -y
    sudo hostnamectl set-hostname ${var.name} --static

    # Download the latest EPEL release RPM for RHEL 9
    sudo curl -O https://dl.fedoraproject.org/pub/epel/epel-release-latest-9.noarch.rpm

    # Install it manually
    sudo rpm -ivh epel-release-latest-9.noarch.rpm

    # Clean and refresh DNF
    sudo dnf clean all
    sudo dnf makecache

    #  Install Basic Utilities

    sudo dnf install vim wget git unzip net-tools bind-utils telnet traceroute nmap htop tree bash-completion iputils python3.11-pip -y

    # Security & Networking Tools
    sudo dnf install -y tcpdump openssl openssh-clients

  EOF

  tags = {
    Name = var.name
  }
}

resource "aws_security_group" "tool-sg" {
  name        = "${var.name}-sg"
  description = "Allow inbound traffic and all outbound traffic"

  tags = {
    Name = "${var.name}-sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh" {
  security_group_id = aws_security_group.tool-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
  description       = "Allow ssh inbound traffic"
}

resource "aws_vpc_security_group_ingress_rule" "app_port" {
  for_each          = var.ports
  security_group_id = aws_security_group.tool-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "tcp"
  from_port         = each.value
  to_port           = each.value
  description       = "Allow app port inbound traffic"
}

resource "aws_vpc_security_group_egress_rule" "egress_allow_all" {
  security_group_id = aws_security_group.tool-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}