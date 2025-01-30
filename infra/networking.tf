#######################################################################################################################
#### VPC
#######################################################################################################################
resource "aws_vpc" "extrato_lancamento_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags                 = local.custom_tags
}

resource "aws_vpc_endpoint" "extrato_lancamento_vpc_endpoint_s3" {
  service_name      = "com.amazonaws.${data.aws_region.current.id}.s3"
  vpc_endpoint_type = "Gateway"
  vpc_id            = aws_vpc.extrato_lancamento_vpc.id
  route_table_ids = [
    aws_route_table.extrato_lancamento_private_route_table_1.id,
    aws_route_table.extrato_lancamento_private_route_table_2.id,
    aws_route_table.extrato_lancamento_private_route_table_3.id
  ]
}

#######################################################################################################################
#### Internet Gateway
#######################################################################################################################
resource "aws_internet_gateway" "extrato_lancamento_gw" {
  tags = local.custom_tags
}

resource "aws_internet_gateway_attachment" "extrato_lancamento_gw_attachment" {
  internet_gateway_id = aws_internet_gateway.extrato_lancamento_gw.id
  vpc_id              = aws_vpc.extrato_lancamento_vpc.id
}

#######################################################################################################################
#### Public Subnets
#######################################################################################################################
resource "aws_subnet" "extrato_lancamento_public_subnet_1" {
  vpc_id                  = aws_vpc.extrato_lancamento_vpc.id
  cidr_block              = var.public_subnet1_cidr
  availability_zone       = data.aws_availability_zones.availability_zones.names[0]
  map_public_ip_on_launch = true
  tags                    = local.custom_tags
}

resource "aws_subnet" "extrato_lancamento_public_subnet_2" {
  vpc_id                  = aws_vpc.extrato_lancamento_vpc.id
  cidr_block              = var.public_subnet2_cidr
  availability_zone       = data.aws_availability_zones.availability_zones.names[1]
  map_public_ip_on_launch = true
  tags                    = local.custom_tags
}

resource "aws_subnet" "extrato_lancamento_public_subnet_3" {
  vpc_id                  = aws_vpc.extrato_lancamento_vpc.id
  cidr_block              = var.public_subnet3_cidr
  availability_zone       = data.aws_availability_zones.availability_zones.names[2]
  map_public_ip_on_launch = true
  tags                    = local.custom_tags
}

#######################################################################################################################
#### Private Subnets
#######################################################################################################################
resource "aws_subnet" "extrato_lancamento_private_subnet_1" {
  vpc_id                  = aws_vpc.extrato_lancamento_vpc.id
  cidr_block              = var.private_subnet1_cidr
  availability_zone       = data.aws_availability_zones.availability_zones.names[0]
  map_public_ip_on_launch = true
  tags                    = local.custom_tags
}

resource "aws_subnet" "extrato_lancamento_private_subnet_2" {
  vpc_id                  = aws_vpc.extrato_lancamento_vpc.id
  cidr_block              = var.private_subnet2_cidr
  availability_zone       = data.aws_availability_zones.availability_zones.names[1]
  map_public_ip_on_launch = true
  tags                    = local.custom_tags
}

resource "aws_subnet" "extrato_lancamento_private_subnet_3" {
  vpc_id                  = aws_vpc.extrato_lancamento_vpc.id
  cidr_block              = var.private_subnet3_cidr
  availability_zone       = data.aws_availability_zones.availability_zones.names[2]
  map_public_ip_on_launch = true
  tags                    = local.custom_tags
}

#######################################################################################################################
#### Routes and Route Table
#######################################################################################################################
resource "aws_route_table" "extrato_lancamento_public_route_table" {
  vpc_id = aws_vpc.extrato_lancamento_vpc.id
  route  = []
  tags   = local.custom_tags
}

resource "aws_route_table" "extrato_lancamento_private_route_table_1" {
  vpc_id = aws_vpc.extrato_lancamento_vpc.id
  route  = []
  tags   = local.custom_tags
}

resource "aws_route_table" "extrato_lancamento_private_route_table_2" {
  vpc_id = aws_vpc.extrato_lancamento_vpc.id
  route  = []
  tags   = local.custom_tags
}

resource "aws_route_table" "extrato_lancamento_private_route_table_3" {
  vpc_id = aws_vpc.extrato_lancamento_vpc.id
  route  = []
  tags   = local.custom_tags
}

resource "aws_route" "extrato_lancamento_public_route" {
  route_table_id         = aws_route_table.extrato_lancamento_public_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.extrato_lancamento_gw.id
}

resource "aws_route_table_association" "extrato_lancamento_public_route_table_association_subnet_1" {
  subnet_id      = aws_subnet.extrato_lancamento_public_subnet_1.id
  route_table_id = aws_route_table.extrato_lancamento_public_route_table.id
}

resource "aws_route_table_association" "extrato_lancamento_public_route_table_association_subnet_2" {
  subnet_id      = aws_subnet.extrato_lancamento_public_subnet_2.id
  route_table_id = aws_route_table.extrato_lancamento_public_route_table.id
}

resource "aws_route_table_association" "extrato_lancamento_public_route_table_association_subnet_3" {
  subnet_id      = aws_subnet.extrato_lancamento_public_subnet_3.id
  route_table_id = aws_route_table.extrato_lancamento_public_route_table.id
}

resource "aws_route_table_association" "extrato_lancamento_private_route_table_association_subnet_1" {
  subnet_id      = aws_subnet.extrato_lancamento_private_subnet_1.id
  route_table_id = aws_route_table.extrato_lancamento_private_route_table_1.id
}

resource "aws_route_table_association" "extrato_lancamento_private_route_table_association_subnet_2" {
  subnet_id      = aws_subnet.extrato_lancamento_private_subnet_2.id
  route_table_id = aws_route_table.extrato_lancamento_private_route_table_2.id
}

resource "aws_route_table_association" "extrato_lancamento_private_route_table_association_subnet_3" {
  subnet_id      = aws_subnet.extrato_lancamento_private_subnet_3.id
  route_table_id = aws_route_table.extrato_lancamento_private_route_table_3.id
}

#######################################################################################################################
#### Security Groups
#######################################################################################################################
resource "aws_security_group" "extrato_lancamento_sg" {
  name        = "${local.domain_name}-sg"
  description = "Security group with a self-referencing inbound rule."
  vpc_id      = aws_vpc.extrato_lancamento_vpc.id
  tags        = local.custom_tags
}

resource "aws_vpc_security_group_ingress_rule" "extrato_lancamento_sg_ingress_all" {
  security_group_id = aws_security_group.extrato_lancamento_sg.id
  cidr_ipv4         = aws_vpc.extrato_lancamento_vpc.cidr_block
  ip_protocol       = "-1" # semantically equivalent to all ports
}

resource "aws_vpc_security_group_egress_rule" "extrato_lancamento_sg_egress_all" {
  security_group_id = aws_security_group.extrato_lancamento_sg.id
  cidr_ipv4         = aws_vpc.extrato_lancamento_vpc.cidr_block
  ip_protocol       = "-1" # semantically equivalent to all ports
}
