# creating vpc
resource "aws_vpc" "vpc-main"  {
    cidr_block = "192.168.0.0/16"
    instance_tenancy = "default"
    enable_dns_support = "true"
    enable_dns_hostnames = "true"
    enable_classiclink = "false"
    tags =  {
        Name = "vpc_main"
    }
}

# creating public subnets

resource "aws_subnet" "vpc-main-public1"   {
    vpc_id  = aws_vpc.vpc-main.id
    cidr_block = "192.168.1.0/24"
    map_public_ip_on_launch = "true"
    availability_zone = "us-east-1a"
    
    tags = {
        Name = "vpc-main-public1"
    }
}

resource "aws_subnet" "vpc-main-public2"   {
    vpc_id  = aws_vpc.vpc-main.id
    cidr_block = "192.168.2.0/24"
    map_public_ip_on_launch = "true"
    availability_zone = "us-east-1b"
    
    tags = {
        Name = "vpc-main-public2"
    }
}

resource "aws_subnet" "vpc-main-public3"   {
    vpc_id  = aws_vpc.vpc-main.id
    cidr_block = "192.168.3.0/24"
    map_public_ip_on_launch = "true"
    availability_zone = "us-east-1c"
    
    tags = {
        Name = "vpc-main-public3"
    }
}

# creating private subnets

resource "aws_subnet" "vpc-main-private1"   {
    vpc_id  = aws_vpc.vpc-main.id
    cidr_block = "192.168.4.0/24"
    map_public_ip_on_launch = "false"
    availability_zone = "us-east-1a"
    
    tags = {
        Name = "vpc-main-private1"
    }
}

resource "aws_subnet" "vpc-main-private2"   {
    vpc_id  = aws_vpc.vpc-main.id
    cidr_block = "192.168.5.0/24"
    map_public_ip_on_launch = "false"
    availability_zone = "us-east-1b"
    
    tags = {
        Name = "vpc-main-private2"
    }
}

resource "aws_subnet" "vpc-main-private3"   {
    vpc_id  = aws_vpc.vpc-main.id
    cidr_block = "192.168.6.0/24"
    map_public_ip_on_launch = "false"
    availability_zone = "us-east-1c"
    
    tags = {
        Name = "vpc-main-private3"
    }
}

# creating internet Gateway

resource "aws_internet_gateway" "main-gw"  {
    vpc_id = aws_vpc.vpc-main.id

    tags = {
        Name = "gateway-main"
    }
}

# creating routing table
resource "aws_route_table" "main-public" {
    vpc_id = aws_vpc.vpc-main.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.main-gw.id
    }
    tags = {
        Name = "main-public"
    }
}

# Route Associated Public subnets
resource "aws_route_table_association" "public-mian-1"  {
    subnet_id = aws_subnet.vpc-main-public1.id
    route_table_id = aws_route_table.main-public.id
}

resource "aws_route_table_association" "public-mian-2"  {
    subnet_id = aws_subnet.vpc-main-public2.id
    route_table_id = aws_route_table.main-public.id
}

resource "aws_route_table_association" "public-mian-3"  {
    subnet_id = aws_subnet.vpc-main-public3.id
    route_table_id = aws_route_table.main-public.id
}
