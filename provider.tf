provider "aws" {
  region = "us-east-1"
 profile = "hutto-admin"
  }
locals {
  tag-name = tayo
}

resource "aws_vpc" "vpc1" {        
  cidr_block = var.vpccidrblock

  tags = {
    Name = "tayo-vpc"
  }
 }

resource "aws_instance" "tayo-instance" {
  ami               = var.myami
  instance_type     = var.instancetype
  availability_zone = var.az
  key_name          = var.keyname
  subnet_id         = aws_subnet.subnet1.id
  count             = 2

  tags = {
    Name = "tayo.${count.index}"
  }

}
resource "aws_subnet" "subnet1" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = var.subnetcidrblock
  availability_zone = var.az

  tags = {
    Name = "${local.tag-name}-private-subnet"
  }
}

resource "aws_lb" "test" {
  name               = "test-lb-tf"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.lb_sg.id]
  subnets            = aws_subnet.public.*.id

  enable_deletion_protection = true

  access_logs {
    bucket  = aws_s3_bucket.lb_logs.bucket
    prefix  = "test-lb"
    enabled = true
  }

  tags = {
    Environment = "production"
  }
}

resource "aws_eip" "eip1" {
  
  tags = {
    Name = "${local.tag-name}-Eip"
    }
}

resource "aws_nat_gateway" "Natgateway" {
  allocation_id = aws_eip.eip1.id
  subnet_id     = aws_subnet.subnet1.id

  tags = {
    Name = "${local.tag-name}-Nat-gateway"
  }

  depends_on = [aws_internet_gateway.gw]
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.vpc1.id

  tags = {
    Name = "${local.tag-name}-IGW"
  }
}

resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.main.id

  ingress = [
    {
      description      = "TLS from VPC"
      from_port        = 443
      to_port          = 443
      protocol         = "tcp"
      cidr_blocks      = [aws_vpc.main.cidr_block]
      ipv6_cidr_blocks = [aws_vpc.main.ipv6_cidr_block]
    }
  ]

  egress = [
    {
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
    }
  ]

  tags = {
    Name = "allow_tls"
  }
}