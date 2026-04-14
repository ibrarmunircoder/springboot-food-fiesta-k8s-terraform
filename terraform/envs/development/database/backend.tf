terraform {
  backend "s3" {
    region       = ""
    bucket       = ""
    key          = "dev/database/terraform.tfstate"
    use_lockfile = true
    encrypt      = true
  }
}