#Define External IP 
resource "aws_eip" "lionel-nat" {
  # vpc = true
  domain = "vpc"
}

resource "aws_nat_gateway" "lionel-nat-gw" {
  allocation_id = aws_eip.lionel-nat.id
  subnet_id     = aws_subnet.lionelvpc-public-1.id
  depends_on    = [aws_internet_gateway.lionel-gw]
}

resource "aws_route_table" "lionel-private" {
  vpc_id = aws_vpc.lionelvpc.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.lionel-nat-gw.id
  }

  tags = {
    Name = "lionel-private"
  }
}

# route associations private
resource "aws_route_table_association" "lionel-private-1-a" {
  subnet_id      = aws_subnet.lionelvpc-private-1.id
  route_table_id = aws_route_table.lionel-private.id
}

resource "aws_route_table_association" "lionel-private-1-b" {
  subnet_id      = aws_subnet.lionelvpc-private-2.id
  route_table_id = aws_route_table.lionel-private.id
}

resource "aws_route_table_association" "lionel-private-1-c" {
  subnet_id      = aws_subnet.lionelvpc-private-3.id
  route_table_id = aws_route_table.lionel-private.id
}