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

  enable_deletion_protection = true


  tags = {
    Name = "${local.tag-name}-App-lb"
  }
}
resource "aws_lb_target_group" "lb-tg" {
  name        = "server-lb-tg"
  port        = 80
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      = aws_vpc.vpc1.id

  health_check {
    healthy_threshold =""
    interval =""
    matcher =""
    path =""
    port =""
    protocol =""
    timeout =""
    unhealthy_threshold =""
  }
}