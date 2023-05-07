
resource "aws_elasticache_subnet_group" "redis_subnet_group" {
  name       = "redis-cache-subnet"
  subnet_ids = [aws_subnet.private[0].id]
}

resource "aws_elasticache_cluster" "redis" {
  engine = "redis"

  cluster_id           = "redis-cluster"
  node_type            = "cache.t4g.micro"

  num_cache_nodes      = 1
  engine_version       = "7.0"
  port                 = 6379

  apply_immediately    = true

  subnet_group_name    = aws_elasticache_subnet_group.redis_subnet_group.id

  security_group_ids   = [aws_security_group.redis.id]

  tags = {
    name = "sample app redis"
  }
}

