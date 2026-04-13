locals {
  subnet_cidr_blocks = cidrsubnets(var.vpc_cidr, 4, 4, 4, 4, 4, 4)

  public_subnet_cidrs  = slice(local.subnet_cidr_blocks, 0, 2)
  private_subnet_cidrs = slice(local.subnet_cidr_blocks, 2, 4)
  db_subnet_cidrs      = slice(local.subnet_cidr_blocks, 4, 6)

  azs = ["us-east-1a", "us-east-1b"]
}