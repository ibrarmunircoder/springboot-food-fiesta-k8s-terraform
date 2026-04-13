variable "region" {
  type        = string
  description = "AWS region to provision infrastructure"
}

variable "terraform_s3_bucket" {
  type = string
  description = "S3 bucket for terraform state"
}

