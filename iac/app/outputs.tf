# outputs.tf

output "alb_hostname" {
  value = aws_alb.main.dns_name
  description = "Sample App load balancer endpoint"
}

output "redis_endpoint" {
  value       = aws_elasticache_cluster.redis.cache_nodes[0].address
  description = "Redis configuration endpoint"
}
