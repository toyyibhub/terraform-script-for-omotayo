
resource "aws_vpc" "vpc1" {        
  cidr_block = var.vpccidrblock

  tags = {
    Name = "tayo-vpc"
  }
}
  
 resource "aws_subnet" "publicsubnet1" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = var.publicsubnet1cidrblock
  availability_zone = var.az1

  tags = {
    Name = "${local.tag-name}-publicsubnet1"
  }
}
resource "aws_subnet" "publicsubnet2" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = var.publicsubnet2cidrblock
  availability_zone = var.az2

  tags = {
    Name = "${local.tag-name}-publicsubnet2"
  }
}
resource "aws_subnet" "privatesubnet1" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = var.privatesubnet1cidrblock
  availability_zone = var.az1

  tags = {
    Name = "${local.tag-name}-privatesubnet1"
  }
}
resource "aws_subnet" "privatesubnet2" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = var.privatesubnet2cidrblock
  availability_zone = var.az2

  tags = {
    Name = "${local.tag-name}-privatesubnet2"
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
