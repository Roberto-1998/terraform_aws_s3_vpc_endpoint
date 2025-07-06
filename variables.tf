variable "AWS_REGION" {}
variable "EC2_TYPE" {}
variable "SSH_USER" {}
variable "KEY_PAIR_NAME" {}
variable "VPC_NAME" {}
variable "VPC_BLOCK" {}
variable "VPC_AZs" {
  type = list(string)
}
variable "VPC_PUBLIC_SUBNETS" {
  type = list(string)
}
variable "VPC_PRIVATE_SUBNETS" {
  type = list(string)
}
variable "BASTION_OPEN_PORTS" {
  type = list(string)
}
variable "ENDPOINT_OPEN_PORTS" {
  type = list(string)
}