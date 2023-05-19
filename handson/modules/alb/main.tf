resource "aws_lb" "main" {
  load_balancer_type = "application"
  name               = "handson-alb"
  security_groups    = [aws_security_group.alb.id]
  subnets            = var.public_subnet_ids
}

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

