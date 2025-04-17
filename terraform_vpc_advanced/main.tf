resource "aws_vpc" "main" {
  cidr_block       = var.cidr_block
  enable_dns_hostnames = var.enable_dns_hostnames
  enable_dns_support = var.enable_dns_support
  

  tags = merge(
    var.common_tags,{
        Name = "${var.project_name}-${var.env}"
    },
    var.vpc_tags
  )
}
# igw 
resource "aws_internet_gateway" "gateway" {
  vpc_id = aws_vpc.main.id

  tags = merge(
    var.common_tags,{
        Name = "${var.project_name}-${var.env}"
    },
    var.igw_tags

  )
}

#public subnet
resource "aws_subnet" "public_subnet" {
  count = length(var.public_subnet_cidr_block)
  vpc_id     = aws_vpc.main.id
  cidr_block = var.public_subnet_cidr_block[count.index]
  map_public_ip_on_launch = "true"
  availability_zone = local.azs[count.index]

  tags = merge(
    var.common_tags,
    {
    Name = "${var.project_name}-${var.env}-public-${local.azs[count.index]}"
  },
  var.public_subnet_tags
  )
}

# private subnet
resource "aws_subnet" "private_subnet" {
  count = length(var.private_subnet_cidr_block)
  vpc_id     = aws_vpc.main.id
  cidr_block = var.private_subnet_cidr_block[count.index]
  availability_zone = local.azs[count.index]

  tags = merge(
    var.common_tags,
    {
    Name = "${var.project_name}-${var.env}-private-${local.azs[count.index]}"
  },
  var.private_subnet_tags
  )
}
# datsbase subnet

resource "aws_subnet" "database_subnet" {
  count = length(var.database_subnet_cidr_block)
  vpc_id     = aws_vpc.main.id
  cidr_block = var.database_subnet_cidr_block[count.index]
  availability_zone = local.azs[count.index]

  tags = merge(
    var.common_tags,
    {
    Name = "${var.project_name}-${var.env}-database-${local.azs[count.index]}"
  },
  var.database_subnet_tags
  )
}


resource "aws_route_table" "pub_rt" {
  vpc_id = aws_vpc.main.id

  

  tags = merge(
    var.common_tags,{
        Name = "${var.project_name}-${var.env}-public"
    },
    var.public_rt_tags
  )
}
# public aws route always add route separately

resource "aws_route" "public_route" {
  route_table_id            = aws_route_table.pub_rt.id
  destination_cidr_block    = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.gateway.id
}

# adding eip 
resource "aws_eip" "elastic-ip" {

  domain   = "vpc"
}


resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.elastic-ip.id
  subnet_id     = aws_subnet.public_subnet[0].id

  tags = merge(
    var.common_tags,
    {
        Name ="${var.project_name}-${var.env}"
    },
    var.nat_gateway_tags
  )

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.gateway]
}


# private route table
resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.main.id

  

  tags = merge(
    var.common_tags,{
        Name = "${var.project_name}-${var.env}-private"
    },
    var.private_rt_tags
  )
}

# private route
resource "aws_route" "private_route" {
  route_table_id            = aws_route_table.private_rt.id
  destination_cidr_block    = "0.0.0.0/0"
  nat_gateway_id = aws_nat_gateway.nat_gateway.id
}

resource "aws_route_table" "database_rt" {
  vpc_id = aws_vpc.main.id

  

  tags = merge(
    var.common_tags,{
        Name = "${var.project_name}-${var.env}-private"
    },
    var.databse_rt_tags
  )
}

# databse route
resource "aws_route" "database_route" {
  route_table_id            = aws_route_table.private_rt.id
  destination_cidr_block    = "0.0.0.0/0"
  nat_gateway_id = aws_nat_gateway.nat_gateway.id
}