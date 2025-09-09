resource "aws_instance" "tool" {
  ami           = var.ami
  instance_type = var.instance_type
  vpc_security_group_ids = [aws_security_group.tool-sg.id]
  iam_instance_profile = aws_iam_instance_profile.main.name

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

resource "aws_vpc_security_group_egress_rule" "app_port" {
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