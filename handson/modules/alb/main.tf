###############
# ALB
###############
resource "aws_lb" "main" {
  load_balancer_type = "application"
  name               = "handson-alb"
  security_groups    = [aws_security_group.alb.id]
  subnets            = var.public_subnet_ids
}

###############
# SG
###############
resource "aws_security_group" "alb" {
  name        = "handson-alb"
  description = "handson alb"
  vpc_id      = var.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "handson-alb"
  }
}

resource "aws_security_group_rule" "alb_http" {
  security_group_id = aws_security_group.alb.id

  # セキュリティグループ内のリソースへインターネットからのアクセスを許可する
  type = "ingress"

  from_port = 80
  to_port   = 80
  protocol  = "tcp"

  cidr_blocks = ["0.0.0.0/0"]
}

###############
# target group
###############
resource "aws_lb_target_group" "main" {
  name = "handson-alb-tg"
  vpc_id = var.vpc_id
  port = 80
  protocol = "HTTP"
  target_type = "ip"
  health_check {
    port = 80
    path = "/"
  }
}

###############
# listener
###############
resource "aws_lb_listener" "main" {
  port = "80"
  protocol = "HTTP"

  load_balancer_arn = aws_lb.main.arn

  default_action {
    type = "fixed-response"
    fixed_response {
      content_type = "text/plain"
      message_body = "Hello, World"
      status_code  = "200"
    }
  }
}

###############
# listener rule
###############
resource "aws_lb_listener_rule" "main" {
 listener_arn =  aws_lb_listener.main.arn
 priority = 1
 action {
    type = "forward"
    target_group_arn = aws_lb_target_group.main.arn
 }

  condition {
      path_pattern {
        values = ["*"]  
      } 
  }
}