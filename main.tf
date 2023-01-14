#1--Create ECS cluster

resource "aws_ecs_cluster" "cluster" {
  name = "abdi-cluster"
}

resource "aws_ecs_cluster_capacity_providers" "cluster" {
  cluster_name       = aws_ecs_cluster.cluster.name
  capacity_providers = ["FARGATE"]

  default_capacity_provider_strategy {
    base              = 1
    weight            = 100
    capacity_provider = "FARGATE"
  }
}


#2 ECS Service. 
resource "aws_ecs_service" "ecs_service" {
  name            = "Abdi-service"
  cluster         = aws_ecs_cluster.cluster.id
  task_definition = aws_ecs_task_definition.abdi_ecs_task.arn
  launch_type     = "FARGATE"
  desired_count   = 1

  network_configuration {
    subnets = [aws_subnet.private_east_a.id, aws_subnet.private_east_b.id]
  }
}

#Tasks definitions
resource "aws_ecs_task_definition" "abdi_ecs_task" {
  family                   = "service"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE", "EC2"]
  cpu                      = 512
  memory                   = 2048
  container_definitions    = <<DEFINITION
  [
    {
      "name"                 : "centos",
      "image"                : "centos:7",
      "cpu"                  : 512,
      "memory"               : 2048,
      "essential"            : true,
      "portMappings" : [
        {
          "containerPort"    : 80,
          "hostPort"         : 80
        }
      ]
    }
  ]
  DEFINITION
}