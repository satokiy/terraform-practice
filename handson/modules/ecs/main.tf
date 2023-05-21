resource "aws_ecs_service" "main" {
  name = "handson-service"
  # resource作成の依存関係を記述
  depends_on      = [var.ecs_listener_rule]
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.main.arn
  desired_count   = 1
  launch_type     = "FARGATE"
  network_configuration {
    subnets         = var.private_subnet_ids
    security_groups = [aws_security_group.ecs.id]
  }
  load_balancer {
    target_group_arn = var.alb_target_group_arn
    container_name   = "nginx"
    container_port   = 80
  }
}


resource "aws_ecs_cluster" "main" {
  name = "handson-cluster"
}

resource "aws_ecs_task_definition" "main" {
  family                   = "handson-task"
  requires_compatibilities = ["FARGATE"]
  cpu                      = 256
  memory                   = 512

  network_mode          = "awsvpc"
  container_definitions = file("${path.module}/container_definitions.json")
}

###############
# security group
###############
resource "aws_security_group" "ecs" {
  name        = "handson-ecs"
  description = "handson ecs"

  vpc_id = var.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "handson-ecs"
  }
}

resource "aws_security_group_rule" "ecs" {
  security_group_id = aws_security_group.ecs.id

  type = "ingress"

  from_port = 80
  to_port   = 80
  protocol  = "tcp"

  cidr_blocks = ["10.0.0.0/16"]

}

