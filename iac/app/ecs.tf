resource "aws_ecs_cluster" "main" {
  name = "app-cluster"
}

data "template_file" "sample_app" {
  template = file("./web_app.json")

  vars = {
    redis_endpoint = aws_elasticache_cluster.redis.cache_nodes[0].address
    app_image      = var.app_image
    container_port = var.container_port
    fargate_cpu    = var.fargate_cpu
    fargate_memory = var.fargate_memory
    aws_region     = var.aws_region
    app_folder     = var.app_folder
    watch_file     = var.watch_file
  }
}

data "template_file" "sidekiq_app" {
  template = file("./sidekiq_app.json")

  vars = {
    redis_endpoint = aws_elasticache_cluster.redis.cache_nodes[0].address
    app_image      = var.app_image
    fargate_cpu    = var.fargate_cpu
    fargate_memory = var.fargate_memory
    aws_region     = var.aws_region
    app_folder     = var.app_folder
    watch_file     = var.watch_file
  }
}

resource "aws_ecs_task_definition" "app" {
  family                   = "sample-app-task"
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  task_role_arn            = aws_iam_role.ecs_task_execution_role.arn
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.fargate_cpu
  memory                   = var.fargate_memory
  container_definitions    = data.template_file.sample_app.rendered
}

resource "aws_ecs_task_definition" "sidekiq_task_def" {
  family                   = "sidekiq-app-task"
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  task_role_arn            = aws_iam_role.ecs_task_execution_role.arn
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.fargate_cpu
  memory                   = var.fargate_memory
  container_definitions    = data.template_file.sidekiq_app.rendered
}

resource "aws_ecs_service" "main" {
  name            = "app-service"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.app.arn
  desired_count   = var.app_count
  launch_type     = "FARGATE"
  # Required to shell into container using aws ecs execute-command ...
  enable_execute_command = true

  network_configuration {
    security_groups  = [aws_security_group.ecs_tasks.id]
    subnets          = aws_subnet.private.*.id
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = aws_alb_target_group.app.id
    container_name   = "sample-app"
    container_port   = var.container_port
  }

  depends_on = [aws_alb_listener.front_end, aws_iam_role_policy_attachment.ecs_task_execution_role, aws_elasticache_cluster.redis]
}

resource "aws_ecs_service" "sidekiq_service" {
  name            = "sidekiq-service"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.sidekiq_task_def.arn
  desired_count   = var.app_count
  launch_type     = "FARGATE"
  # Required to shell into container using aws ecs execute-command ...
  enable_execute_command = true

  network_configuration {
    security_groups  = [aws_security_group.ecs_tasks.id]
    subnets          = aws_subnet.private.*.id
    assign_public_ip = false
  }

  depends_on = [aws_iam_role_policy_attachment.ecs_task_execution_role, aws_elasticache_cluster.redis]
}
