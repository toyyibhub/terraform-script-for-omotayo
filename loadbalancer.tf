resource "aws_lb" "application-lb" {
  name               = "App-loadbalancer"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.lb-sg.id]
 
  subnet_mapping {
    subnet_id = aws_subnet.publicsubnet1.id
  }

  subnet_mapping {
    subnet_id = aws_subnet.publicsubnet2.id
  }
  subnets            = aws_subnet.public.*.id

  enable_deletion_protection = true


  tags = {
    Environment = "production"
  }
}
