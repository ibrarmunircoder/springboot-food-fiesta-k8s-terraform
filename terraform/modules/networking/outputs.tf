output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "public_subnet_ids" {
  value = aws_subnet.public_subnet[*].id
}

output "private_subnet_ids" {
  value = aws_subnet.private_subnet[*].id
}

output "db_subnet_ids" {
  value = aws_subnet.db_subnet[*].id
}

output "db_sg_id" {
  value = aws_security_group.db_sg.id
}

output "eks_sg_id" {
  value = aws_security_group.eks_sg.id
}