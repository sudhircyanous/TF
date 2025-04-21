resource "aws_autoscaling_group" "project_asg" {
  name                      = "project-asg"
  desired_capacity          = 2
  min_size                  = 1
  max_size                  = 3
  vpc_zone_identifier       = [aws_subnet.alb_subnet_1.id, aws_subnet.alb_subnet_2.id]
  health_check_type         = "EC2"
  health_check_grace_period = 300

  launch_template {
    id      = aws_launch_template.project_lt.id
    version = "$Latest"
  }

  target_group_arns = [aws_lb_target_group.alb_tg.arn]

  tag {
    key                 = "Name"
    value               = "Project-ASG"
    propagate_at_launch = true
  }

  lifecycle {
    create_before_destroy = true
  }

  depends_on = [aws_lb.alb]
}
