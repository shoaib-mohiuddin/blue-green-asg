data "aws_ami" "ubuntu" { # for bastion host
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  owners = ["099720109477"]
}

data "aws_ami" "ami_nginx_blue" {
  most_recent = true
  owners      = [var.owner_id]

  filter {
    name   = "tag:Name"
    values = ["ami-nginx-blue"]
  }
}

data "aws_ami" "ami_nginx_green" {
  most_recent = true
  owners      = [var.owner_id]

  filter {
    name   = "tag:Name"
    values = ["ami-nginx-green"]
  }
}

data "aws_ami" "ami_apache_blue" {
  most_recent = true
  owners      = [var.owner_id]

  filter {
    name   = "tag:Name"
    values = ["ami-apache-blue"]
  }
}

data "aws_ami" "ami_apache_green" {
  most_recent = true
  owners      = [var.owner_id]

  filter {
    name   = "tag:Name"
    values = ["ami-apache-green"]
  }
}

data "aws_vpc" "bg_vpc" {
  filter {
    name   = "tag:Name"
    values = ["bg-vpc"]
  }
}

data "aws_subnet" "public_1" {
  filter {
    name   = "tag:Name"
    values = ["public-subnet-1"]
  }
}

data "aws_subnet" "public_2" {
  filter {
    name   = "tag:Name"
    values = ["public-subnet-2"]
  }
}


data "aws_subnet" "private_1" {
  filter {
    name   = "tag:Name"
    values = ["private-subnet-1"]
  }
}

data "aws_subnet" "private_2" {
  filter {
    name   = "tag:Name"
    values = ["private-subnet-2"]
  }
}