resource "aws_instance" "bastion-host" {
  ami                    = data.aws_ami.amazon_linux.id
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.generated_key.key_name
  subnet_id              = module.vpc.public_subnets[0]
  vpc_security_group_ids = [aws_security_group.bastion-SG.id]

  tags = {
    Name = "bastion-host"
  }
}