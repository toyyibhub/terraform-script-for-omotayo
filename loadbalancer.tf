
resource "aws_lb" "app-lb" {
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


}
resource "aws_lb_listener" "lb-listener" {
  load_balancer_arn = aws_lb.app-lb.arn
  port              = "80"
  protocol          = "HTTP"
  
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.lb-tg.arn
  }
}
