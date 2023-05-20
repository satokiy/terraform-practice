# resource "aws_ecs_service" "main" {
#   name = "handson-service"
#   cluster = aws_ecs_cluster.main.id
#   task_definition = aws_ecs_task_definition.main.arn
#   desired_count = 1

# }


resource "aws_ecs_cluster" "main" {
  name = "handson-cluster"
}

resource "aws_ecs_task_definition" "main" {
    family = "handson-task"
    requires_compatibilities = [ "FARGATE" ]
    cpu = 256
    memory = 512

    network_mode = "awsvpc"
    container_definitions = file("${path.module}/container_definitions.json")
}