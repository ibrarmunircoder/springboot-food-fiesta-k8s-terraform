variable "region" {
  type        = string
  description = "AWS region to provision infrastructure"
  default     = "us-east-1"
}

variable "terraform_s3_bucket" {
  type = string
  description = "S3 bucket for terraform state"
  default = "food-fiesta-terraform-state"
}

