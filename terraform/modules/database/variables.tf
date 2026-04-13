variable "is_production_env" {
  type = bool
  description = "boolean flag to identify the production database"
  default = false
}

variable "password_ssm_pm_name" {
  type = string
  description = "Database password SSM parameter name"
}

variable "db_name" {
  type = string
}

variable "sg_id" {
  type = string
  description = "database security group id"
}

variable "env" {
  type        = string
  description = "The name of the Environment (e.g., dev, staging, production)"
}

variable "subnet_ids" {
  type = list(string)
}