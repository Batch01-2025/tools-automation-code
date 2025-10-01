data "aws_key_pair" "key" {
  key_name = var.key_name
}

data "aws_vpc" "vpc" {
  default = true
}

data "aws_ami" "rhel9" {
  most_recent     = true
  owners          = ["309956199498"]  # Official Account ID for Redhat

  filter {
    name   = "name"
    values = ["RHEL-9"]
  }

  filter {
    name = "architecture"
    values = ["x86_64"]
  }

  filter {
    name = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name = "virtualization-type"
    values = ["hvm"]
  }

}
