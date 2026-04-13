
module "vpc" {
  source = "../../../modules/networking"

  azs                  = local.azs
  cidr                 = var.vpc_cidr
  private_subnet_cirds = local.private_subnet_cidrs
  public_subnet_cirds  = local.public_subnet_cidrs
  db_subnet_cirds      = local.db_subnet_cidrs
  env                  = "development"
}