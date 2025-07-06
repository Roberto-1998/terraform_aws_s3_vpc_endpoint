resource "aws_instance" "bastion-host" {
  ami                    = data.aws_ami.amazon_linux.id
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.generated_key.key_name
  subnet_id              = module.vpc.public_subnets[0]
  vpc_security_group_ids = [aws_security_group.bastion-SG.id]

  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = tls_private_key.bastion_key.private_key_pem
    host        = self.public_ip
  }

  provisioner "file" {
    source      = "bastion_private_key.pem"
    destination = "/home/ec2-user/bastion_private_key.pem"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod 400 bastion_private_key.pem",
    ]
  }




  tags = {
    Name = "bastion-host"
  }
}

resource "aws_instance" "endpoint-instance" {
  ami                    = data.aws_ami.amazon_linux.id
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.generated_key.key_name
  subnet_id              = module.vpc.private_subnets[0]
  vpc_security_group_ids = [aws_security_group.endpoint-SG.id]
  iam_instance_profile = aws_iam_instance_profile.endpoint_profile.name

  tags = {
    Name = "endpoint-instance"
  }
}