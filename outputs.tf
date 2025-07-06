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

output "ami-instances" {
  value = {
    Name = data.aws_ami.amazon_linux.name
    Id   = data.aws_ami.amazon_linux.id
  }
}