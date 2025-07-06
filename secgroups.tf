resource "aws_security_group" "bastion-SG" {
  name        = "bastion-SG"
  description = "Security group for the bastion host"
  vpc_id      = module.vpc.vpc_id

  tags = {
    Name = "bastion-SG"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh_from_anywhere" {

  security_group_id = aws_security_group.bastion-SG.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "tcp"
  for_each          = toset(var.BASTION_OPEN_PORTS)
  from_port         = each.value
  to_port           = each.value
}



resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4_bastion" {
  security_group_id = aws_security_group.bastion-SG.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv6_bastion" {
  security_group_id = aws_security_group.bastion-SG.id
  cidr_ipv6         = "::/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}


resource "aws_security_group" "endpoint-SG" {
  name        = "endpoint-SG"
  description = "Security group for S3 endpoint"
  vpc_id      = module.vpc.vpc_id

  tags = {
    Name = "endpoint-SG"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh_from_bastion" {
  security_group_id            = aws_security_group.endpoint-SG.id
  referenced_security_group_id = aws_security_group.bastion-SG.id
  ip_protocol                  = "tcp"
  for_each                     = toset(var.ENDPOINT_OPEN_PORTS)
  from_port                    = each.value
  to_port                      = each.value
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4_endpoint" {
  security_group_id = aws_security_group.endpoint-SG.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv6_endpoint" {
  security_group_id = aws_security_group.endpoint-SG.id
  cidr_ipv6         = "::/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}
