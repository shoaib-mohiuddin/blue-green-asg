resource "aws_launch_template" "blue_template" {
  name_prefix            = "blue-template"
  image_id               = data.aws_ami.ami_nginx_blue.id
  instance_type          = "t3.small"
  vpc_security_group_ids = [aws_security_group.asg_sg.id]
}

resource "aws_autoscaling_group" "asg_blue" {
  vpc_zone_identifier = [
    data.aws_subnet.private_1.id,
    data.aws_subnet.private_2.id
  ]
  desired_capacity = 2
  max_size         = 2
  min_size         = 0

  launch_template {
    id      = aws_launch_template.blue_template.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "Blue-Instance"
    propagate_at_launch = true
  }
}

resource "aws_autoscaling_policy" "asg_policy_blue" {
  name                   = "asg-policy-blue"
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.asg_blue.name
}

resource "aws_launch_template" "green_template" {
  name_prefix            = "green-template"
  image_id               = data.aws_ami.ami_nginx_green.id
  instance_type          = "t3.small"
  vpc_security_group_ids = [aws_security_group.asg_sg.id]
}

resource "aws_autoscaling_group" "asg_green" {
  vpc_zone_identifier = [
    data.aws_subnet.private_1.id,
    data.aws_subnet.private_2.id
  ]
  desired_capacity = 2
  max_size         = 2
  min_size         = 0

  launch_template {
    id      = aws_launch_template.green_template.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "Green-Instance"
    propagate_at_launch = true
  }
}

resource "aws_autoscaling_policy" "asg_policy_green" {
  name                   = "asg-policy-green"
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.asg_green.name
}