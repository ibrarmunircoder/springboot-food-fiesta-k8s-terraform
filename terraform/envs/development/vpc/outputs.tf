output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnet_ids" {
  value = module.vpc.public_subnet_ids
}

output "private_subnet_ids" {
  value = module.vpc.private_subnet_ids
}

output "db_subnet_ids" {
  value = module.vpc.db_subnet_ids
}

output "db_sg_id" {
  value = module.vpc.db_sg_id
}

output "eks_sg_id" {
  value = module.vpc.eks_sg_id
}