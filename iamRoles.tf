resource "aws_iam_role" "s3-read-only-access-role" {
  name = "s3-read-only-access-role"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "ec2.amazonaws.com"
        },
        Action = "sts:AssumeRole"
      }
    ]
  })

  tags = {
    name = "s3-read-only-access-role"
  }
}

resource "aws_iam_role_policy_attachment" "s3_readonly_attach" {
  role       = aws_iam_role.s3-read-only-access-role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
}

resource "aws_iam_instance_profile" "endpoint_profile" {
  name = "endpoint_profile"
  role = aws_iam_role.s3-read-only-access-role.name
}