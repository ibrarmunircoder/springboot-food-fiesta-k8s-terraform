variable "cidr" {
  type        = string
  description = "The IPv4 CIDR block for the VPC"
  default     = "10.0.0.0/16"
}

variable "env" {
  type        = string
  description = "The name of the Environment (e.g., dev, staging, production)"
}

variable "public_subnet_cirds" {
  type        = list(string)
  description = "A list of public subnets inside the VPC."
  default     = []
}

variable "private_subnet_cirds" {
  type        = list(string)
  description = "A list of private subnets inside the VPC."
  default     = []
}

variable "db_subnet_cirds" {
  type        = list(string)
  description = "A list of db subnets inside the VPC."
  default     = []
}

variable "azs" {
  type        = list(string)
  description = "A list of availability zones"
}