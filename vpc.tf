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


module "vpc_endpoint_s3" {
  source          = "./modules/vpc_endpoint_s3"
  vpc_id          = module.vpc.vpc_id
  region          = var.AWS_REGION
  route_table_ids = module.vpc.private_route_table_ids
  tags = {
    Name        = "s3-endpoint"
    Environment = "dev"
  }

}