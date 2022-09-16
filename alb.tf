resource "aws_lb" "bg_alb" {
  name               = "bg-alb"
  security_groups    = [aws_security_group.alb_sg.id]
  load_balancer_type = "application"

  subnets = [
    data.aws_subnet.public_1.id,
    data.aws_subnet.public_2.id
  ]

  tags = {
    Name = "bg-alb"
  }
}

resource "aws_alb_listener" "listener_http" {
  load_balancer_arn = aws_lb.bg_alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "forward"

    forward {
      target_group {
        arn    = aws_alb_target_group.tg_blue.arn
        weight = 50
      }

      target_group {
        arn    = aws_alb_target_group.tg_green.arn
        weight = 50
      }
    }
  }
}

resource "aws_alb_target_group" "tg_blue" {
  name     = "alb-tg-blue"
  port     = 80
  protocol = "HTTP"
  vpc_id   = data.aws_vpc.bg_vpc.id

  health_check {
    port     = 80
    protocol = "HTTP"
  }
}

resource "aws_autoscaling_attachment" "asg_attachment_blue" {
  autoscaling_group_name = aws_autoscaling_group.asg_blue.id
  lb_target_group_arn    = aws_alb_target_group.tg_blue.arn
}

resource "aws_alb_target_group" "tg_green" {
  name     = "alb-tg-green"
  port     = 80
  protocol = "HTTP"
  vpc_id   = data.aws_vpc.bg_vpc.id

  health_check {
    port     = 80
    protocol = "HTTP"
  }
}

resource "aws_autoscaling_attachment" "asg_attachment_green" {
  autoscaling_group_name = aws_autoscaling_group.asg_green.id
  lb_target_group_arn    = aws_alb_target_group.tg_green.arn
}