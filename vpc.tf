module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = var.VPC_NAME
  cidr = var.VPC_BLOCK

  azs             = var.VPC_AZs
  public_subnets  = var.VPC_PUBLIC_SUBNETS
  private_subnets = var.VPC_PRIVATE_SUBNETS

  enable_nat_gateway      = false
  enable_vpn_gateway      = true
  map_public_ip_on_launch = true

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}


resource "aws_vpc_endpoint" "s3_endpoint" {
  vpc_id            = module.vpc.vpc_id
  service_name      = "com.amazonaws.${var.AWS_REGION}.s3"
  vpc_endpoint_type = "Gateway"

  route_table_ids = [
    module.vpc.private_route_table_ids[0]
  ]

  tags = {
    Name = "s3-endpoint"
  }
}
