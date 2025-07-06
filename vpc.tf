module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "MyVPC"
  cidr = "192.168.0.0/26"

  azs             = ["us-east-1a"]
  public_subnets  = ["192.168.0.0/27"]
  private_subnets = ["192.168.0.32/27"]

  enable_nat_gateway      = false
  enable_vpn_gateway      = true
  map_public_ip_on_launch = true


  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}