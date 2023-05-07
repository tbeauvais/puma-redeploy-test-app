# outputs.tf

output "alb_hostname" {
  value = aws_alb.main.dns_name
}

output "redis_endpoint" {
  value       = aws_elasticache_cluster.redis.configuration_endpoint
  description = "Redis configuration endpoint"
}
