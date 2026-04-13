variable "region" {
  type        = string
  description = "AWS region to provision infrastructure"
  default     = "us-east-1"
}

variable "vpc_cidr" {
  type        = string
  description = "The IPv4 CIDR block for the VPC"
  default     = "10.0.0.0/16"
}