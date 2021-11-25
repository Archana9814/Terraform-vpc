# Nat gatway
resource "aws_eip" "nat" {
    vpc = true
}

resource "aws_nat_gateway" "nat-gw"  {
    allocation_id = aws_eip.nat.allocation_id
    subnet_id = aws_subnet.vpc-main-public1.id
    depends_on = [aws_internet_gateway.main-gw]
}

# VPC setup for NAT 

resource "aws_route_table" "private-main"  {
    vpc_id = aws_vpc.vpc-main.id
    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = aws_nat_gateway.nat-gw.id
    }
    tags = {
        Name = "private-main"
    }
}

# Private Route table association

resource "aws_route_table_association" "vpc-main-private-1"  {
    subnet_id = aws_subnet.vpc-main-private1.id
    route_table_id = aws_route_table.private-main.id
}

resource "aws_route_table_association" "vpc-main-private-2"  {
    subnet_id = aws_subnet.vpc-main-private2.id
    route_table_id = aws_route_table.private-main.id
}

resource "aws_route_table_association" "vpc-main-private-3"  {
    subnet_id = aws_subnet.vpc-main-private3.id
    route_table_id = aws_route_table.private-main.id
}
