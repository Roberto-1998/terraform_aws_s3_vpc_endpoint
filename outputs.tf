output "vpc_id" {
  value = module.vpc.vpc_id
}

output "private_subnet_ids" {
  value = module.vpc.private_subnets
}

output "public_ip_subnet_ids" {
  value = module.vpc.private_subnets
}

output "vpc_endpoint_id" {
  value = module.vpc_endpoint_s3.vpc_endpoint_id
}

output "ami-instance_id" {
  value = data.aws_ami.amazon_linux.id
}

output "bastion_host_public_ip" {
  value = aws_instance.bastion-host.public_ip
}

output "endpoint_host_private_ip" {
  value = aws_instance.endpoint-instance.private_ip
}