resource "random_string" "password" {
  length  = 32
  special = false
}

resource "aws_ssm_parameter" "password" {
  name  = var.password_ssm_pm_name
  type  = "SecureString"
  value = random_string.password.result
}

resource "aws_db_parameter_group" "this" {
  name   = "postgres17-no-ssl-pg"
  family = "postgres17"

  parameter {
    name  = "rds.force_ssl"
    value = "0"
  }
}



resource "aws_db_subnet_group" "this" {
  name       = "${var.env}-db-subnet-group"
  subnet_ids = var.subnet_ids
}

resource "aws_db_instance" "this" {
  identifier             = "${var.env}-db"
  allocated_storage      = var.is_production_env ? 50 : 10
  storage_type           = "gp2"
  engine                 = "postgres"
  engine_version         = "17.2"
  instance_class         = "db.t3.micro"
  username               = var.env
  db_name                = var.db_name
  publicly_accessible = false
  password               = random_string.password.result
  db_subnet_group_name   = aws_db_subnet_group.this.name
  vpc_security_group_ids = [aws_security_group.db_sg.id]
  skip_final_snapshot    = true
  multi_az               = var.is_production_env
  parameter_group_name = aws_db_parameter_group.this.name
}