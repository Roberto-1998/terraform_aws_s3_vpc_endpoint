variable "vpc_id" {
  description = "ID of the VPC where to create the endpoint"
  type = string
}

variable "region" {
  description = "AWS Region"
  type = string
}

variable "route_table_ids" {
  description = "List of route table IDs to associate with the endpoint"
  type = list(string)
}

variable "tags" {
  description = "Tags to apply to the VPC Endpoint"
  type = map(string)
  default = {}
}

