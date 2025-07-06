output "vpc_endpoint_id" {
  description = "ID of the VPC Endpoint"
  value       = aws_vpc_endpoint.s3_endpoint.id
}

output "vpc_endpoint_dns_entries" {
  description = "DNS entries of the VPC Endpoint"
  value       = aws_vpc_endpoint.s3_endpoint.dns_entry
}