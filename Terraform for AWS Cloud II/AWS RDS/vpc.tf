#Create AWS VPC
resource "aws_vpc" "lionelvpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"
  enable_classiclink   = "false"

  tags = {
    Name = "lionelvpc"
  }
}

# Public Subnets in Custom VPC
resource "aws_subnet" "lionelvpc-public-1" {
  vpc_id                  = aws_vpc.lionelvpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "us-east-1a"

  tags = {
    Name = "lionelvpc-public-1"
  }
}

resource "aws_subnet" "lionelvpc-public-2" {
  vpc_id                  = aws_vpc.lionelvpc.id
  cidr_block              = "10.0.2.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "us-east-1b"

  tags = {
    Name = "lionelvpc-public-2"
  }
}

resource "aws_subnet" "lionelvpc-public-3" {
  vpc_id                  = aws_vpc.lionelvpc.id
  cidr_block              = "10.0.3.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "us-east-1c"

  tags = {
    Name = "lionelvpc-public-3"
  }
}

# Private Subnets in Custom VPC
resource "aws_subnet" "lionelvpc-private-1" {
  vpc_id                  = aws_vpc.lionelvpc.id
  cidr_block              = "10.0.4.0/24"
  map_public_ip_on_launch = "false"
  availability_zone       = "us-east-1a"

  tags = {
    Name = "lionelvpc-private-1"
  }
}

resource "aws_subnet" "lionelvpc-private-2" {
  vpc_id                  = aws_vpc.lionelvpc.id
  cidr_block              = "10.0.5.0/24"
  map_public_ip_on_launch = "false"
  availability_zone       = "us-east-1b"

  tags = {
    Name = "lionelvpc-private-2"
  }
}

resource "aws_subnet" "lionelvpc-private-3" {
  vpc_id                  = aws_vpc.lionelvpc.id
  cidr_block              = "10.0.6.0/24"
  map_public_ip_on_launch = "false"
  availability_zone       = "us-east-1c"

  tags = {
    Name = "lionelvpc-private-3"
  }
}

# Custom internet Gateway
resource "aws_internet_gateway" "lionel-gw" {
  vpc_id = aws_vpc.lionelvpc.id

  tags = {
    Name = "lionel-gw"
  }
}

#Routing Table for the Custom VPC
resource "aws_route_table" "lionel-public" {
  vpc_id = aws_vpc.lionelvpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.lionel-gw.id
  }

  tags = {
    Name = "lionel-public-1"
  }
}

resource "aws_route_table_association" "lionel-public-1-a" {
  subnet_id      = aws_subnet.lionelvpc-public-1.id
  route_table_id = aws_route_table.lionel-public.id
}

resource "aws_route_table_association" "lionel-public-2-a" {
  subnet_id      = aws_subnet.lionelvpc-public-2.id
  route_table_id = aws_route_table.lionel-public.id
}

resource "aws_route_table_association" "lionel-public-3-a" {
  subnet_id      = aws_subnet.lionelvpc-public-3.id
  route_table_id = aws_route_table.lionel-public.id
}
