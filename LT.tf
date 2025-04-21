resource "aws_launch_template" "project_lt" {
  name_prefix   = "project-lt-"
  image_id      = "ami-0c02fb55956c7d316"  # Amazon Linux 2 (us-east-1)
  instance_type = "t2.micro"
  key_name      = "TF"  # Using your existing key pair named 'TF'

  vpc_security_group_ids = [aws_security_group.alb_sg.id]

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "Project-ASG-Instance"
    }
  }
}
