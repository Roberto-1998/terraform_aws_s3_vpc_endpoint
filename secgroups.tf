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
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_vpc_security_group_ingress_rule" "allow_http_from_anywhere" {
  security_group_id = aws_security_group.bastion-SG.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_ingress_rule" "allow_https_from_anywhere" {
  security_group_id = aws_security_group.bastion-SG.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
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
  from_port                    = 22
  ip_protocol                  = "tcp"
  to_port                      = 22
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
