locals {
  vpc_id = aws_vpc.vpc.id

  len_private_subnets = length(var.private_subnet_cirds)
  len_public_subnets  = length(var.public_subnet_cirds)
  len_db_subnets      = length(var.db_subnet_cirds)

  create_private_subnets = local.len_private_subnets > 0
  create_public_subnets  = local.len_public_subnets > 0
  create_db_subnets      = local.len_db_subnets > 0
}
