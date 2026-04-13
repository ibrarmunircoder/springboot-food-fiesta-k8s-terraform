

resource "aws_security_group" "eks_sg" {
  name   = "${var.env}-eks-sg"
  vpc_id = local.vpc_id
}



resource "aws_vpc_security_group_egress_rule" "eks_sg_allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.eks_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}


resource "aws_security_group" "db_sg" {
  name   = "${var.env}-db-sg"
  vpc_id = local.vpc_id
}

resource "aws_vpc_security_group_ingress_rule" "allow_alb" {
  description                  = "Allow app subnet to access db"
  security_group_id            = aws_security_group.db_sg.id
  referenced_security_group_id = aws_security_group.eks_sg.id
  from_port                    = 5432
  ip_protocol                  = "tcp"
  to_port                      = 5432
}


resource "aws_vpc_security_group_egress_rule" "db_sg_allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.db_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}