# Application Load Balancer
resource "aws_lb" "alb" {
  name               = "project-alb"
  load_balancer_type = "application"
  subnets            = [aws_subnet.alb_subnet_1.id, aws_subnet.alb_subnet_2.id]
  security_groups    = [aws_security_group.alb_sg.id]

  tags = {
    Name = "Project-ALB"
  }
}

# Target Group (for EC2 instances)
resource "aws_lb_target_group" "alb_tg" {
  name     = "project-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.alb_vpc.id

  health_check {
    path                = "/"
    protocol            = "HTTP"
    matcher             = "200-399"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }

  tags = {
    Name = "Project-TG"
  }
}

# Listener (connects ALB to TG on port 80)
resource "aws_lb_listener" "alb_listener" {
  load_balancer_arn = aws_lb.alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb_tg.arn
  }
}
