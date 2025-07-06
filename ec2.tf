resource "aws_instance" "bastion-host" {
  ami                    = data.aws_ami.amazon_linux.id
  instance_type          = var.EC2_TYPE
  key_name               = aws_key_pair.generated_key.key_name
  subnet_id              = module.vpc.public_subnets[0]
  vpc_security_group_ids = [aws_security_group.bastion-SG.id]

  connection {
    type        = "ssh"
    user        = var.SSH_USER
    private_key = tls_private_key.bastion_key.private_key_pem
    host        = self.public_ip
  }

  provisioner "file" {
    source      = var.KEY_PAIR_NAME
    destination = "/home/ec2-user/${var.KEY_PAIR_NAME}"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod 400 ${var.KEY_PAIR_NAME}",
    ]
  }
  tags = {
    Name = "bastion-host"
  }
}

resource "aws_instance" "endpoint-instance" {
  ami                    = data.aws_ami.amazon_linux.id
  instance_type          = var.EC2_TYPE
  key_name               = aws_key_pair.generated_key.key_name
  subnet_id              = module.vpc.private_subnets[0]
  vpc_security_group_ids = [aws_security_group.endpoint-SG.id]
  iam_instance_profile   = aws_iam_instance_profile.endpoint_profile.name

  tags = {
    Name = "endpoint-instance"
  }
}