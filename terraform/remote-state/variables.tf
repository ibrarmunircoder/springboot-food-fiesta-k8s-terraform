variable "region" {
  type = string
  description = "AWS region to provision infrastructure"
}


variable "bucket_name" {
  type = string
  description = "S3 bucket for terraform state"
}