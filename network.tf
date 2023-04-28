resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.vpc.id

    tags = {
        Name = "Internet gateway"
    }
}

resource "aws_route_table" "public_route_table" {
    vpc_id = aws_vpc.vpc.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw.id
    }

    tags = {
        Name = "public route table"
    }
}

resource "aws_route_table_association" "public_subnet_association" {
    subnet_id      = aws_subnet.public_subnet.id
    route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "host_subnet_1_association" {
    subnet_id      = aws_subnet.host_subnet_1.id
    route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "host_subnet_2_association" {
    subnet_id      = aws_subnet.host_subnet_2.id
    route_table_id = aws_route_table.public_route_table.id
}

# resource "aws_nat_gateway" "db_nat" {
#     subnet_id = aws_subnet.db_subnet_1.id
#     connectivity_type = "private"

#     tags = {
#         Name = "db_nat"
#     }
# }

# resource "aws_route_table" "db_route_table" {
#     vpc_id = aws_vpc.vpc.id

#     route {
#         cidr_block = "10.0.0.0/16"
#         gateway_id = aws_nat_gateway.db_nat.id
#     }

#     tags = {
#         Name = "db route table"
#     }
# }

# resource "aws_route_table_association" "db_subnet_association_1" {
#     subnet_id      = aws_subnet.db_subnet_1.id
#     route_table_id = aws_route_table.db_route_table.id
# }

# resource "aws_route_table_association" "db_subnet_association_2" {
#     subnet_id      = aws_subnet.db_subnet_2.id
#     route_table_id = aws_route_table.db_route_table.id
# }