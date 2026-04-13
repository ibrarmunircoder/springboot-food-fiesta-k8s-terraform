terraform {
  backend "s3" {
    region       = ""
    bucket       = ""
    key          = "s3/terraform.tfstate"
    use_lockfile = true
    encrypt      = true
  }
}