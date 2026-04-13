resource "aws_vpc" "vpc" {
  cidr_block = var.cidr

  enable_dns_support   = true
  enable_dns_hostnames = true
  instance_tenancy     = "default"

  tags = {
    Name = "${var.env}-vpc"
  }
}

################################
# Internet Gaetway
################################

resource "aws_internet_gateway" "igw" {
  vpc_id = local.vpc_id

  tags = {
    Name = "${var.env}-igw"
  }
}



################################
# Private Subnets
################################

resource "aws_subnet" "private_subnet" {
  count             = local.create_private_subnets ? local.len_private_subnets : 0
  vpc_id            = local.vpc_id
  cidr_block        = element(var.private_subnet_cirds, count.index)
  availability_zone = element(var.azs, count.index)

  tags = {
    "Name"                                                 = "${var.env}-private-${element(var.azs, count.index)}"
    "kubernetes.io/role/internal-elb"                      = "1"
    "kubernetes.io/cluster/${var.env}-${var.cluster_name}" = "owned"
  }
}


################################
# Public Subnets
################################


resource "aws_subnet" "public_subnet" {
  count                   = local.create_public_subnets ? local.len_public_subnets : 0
  vpc_id                  = local.vpc_id
  cidr_block              = element(var.public_subnet_cirds, count.index)
  availability_zone       = element(var.azs, count.index)
  map_public_ip_on_launch = true

  tags = {
    "Name"                                                 = "${var.env}-public-${element(var.azs, count.index)}"
    "kubernetes.io/role/elb"                               = "1"
    "kubernetes.io/cluster/${var.env}-${var.cluster_name}" = "owned"
  }
}

################################
# Database Subnets
################################


resource "aws_subnet" "db_subnet" {
  count = local.create_db_subnets ? local.len_db_subnets : 0

  vpc_id            = local.vpc_id
  cidr_block        = element(var.db_subnet_cirds, count.index)
  availability_zone = element(var.azs, count.index)

  tags = {
    "Name" = "${var.env}-database-${element(var.azs, count.index)}"
  }
}




################################
# NAT Gaetway
################################

resource "aws_eip" "nat" {
  domain = "vpc"

  tags = {
    Name = "${var.env}-nat-eip"
  }
}

# Only need one NAT gatway for this demo project
resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.id
  subnet_id     = element(aws_subnet.public_subnet[*].id, 0)

  tags = {
    Name = "${var.env}-nat"
  }

  depends_on = [aws_internet_gateway.igw]
}



################################
# Route Tables
################################



resource "aws_route_table" "private" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${var.env}-private-rt"
  }
}

resource "aws_route" "private_nat_gateway_route" {
  route_table_id         = aws_route_table.private.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat.id

  timeouts {
    create = "5m"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${var.env}-public-rt"
  }
}

resource "aws_route" "public_internet_gateway_route" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

resource "aws_route_table" "db" {
  vpc_id = local.vpc_id

  tags = {
    Name = "${var.env}-database-rt"
  }
}


resource "aws_route_table_association" "private" {
  count          = local.create_private_subnets ? local.len_private_subnets : 0
  subnet_id      = element(aws_subnet.private_subnet[*].id, count.index)
  route_table_id = aws_route_table.private.id
}


resource "aws_route_table_association" "public" {
  count          = local.create_public_subnets ? local.len_public_subnets : 0
  subnet_id      = element(aws_subnet.public_subnet[*].id, count.index)
  route_table_id = aws_route_table.public.id
}


resource "aws_route_table_association" "db" {
  count          = local.create_db_subnets ? local.len_db_subnets : 0
  subnet_id      = aws_subnet.db_subnet[count.index].id
  route_table_id = aws_route_table.db.id
}

