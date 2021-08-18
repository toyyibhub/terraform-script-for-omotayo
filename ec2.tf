resource "aws_instance" "instance1" {
  ami               = var.myami
  instance_type     = var.instancetype
  availability_zone = var.az1
  key_name          = var.keyname
  subnet_id         = aws_subnet.privatesubnet1.id
 
  tags = {
    Name = "${local.tag-name}-server1"
  }
}
resource "aws_instance" "instance2" {
  ami               = var.myami
  instance_type     = var.instancetype
  availability_zone = var.az2
  key_name          = var.keyname
  subnet_id         = aws_subnet.privatesubnet2.id
  

  tags = {
    Name = "${local.tag-name}-server2"
  }
}