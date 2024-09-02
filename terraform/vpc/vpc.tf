resource "aws_vpc" "project_vpc" {
  cidr_block = "10.1.0.0/16"
  tags = { Name = "project_vpc" }
}
resource "aws_subnet" "subnet1" {
  vpc_id     = aws_vpc.project_vpc.id
  cidr_block = "10.1.1.0/24"
  map_public_ip_on_launch = "true"
  availability_zone = "us-east-1a"
  tags = { Name = "public_subnet_1" }
}
resource "aws_subnet" "subnet2" {
  vpc_id     = aws_vpc.project_vpc.id
  cidr_block = "10.1.2.0/24"
  map_public_ip_on_launch = "true"
  availability_zone = "us-east-1b"
  tags = { Name = "public_subnet_2" }
}
resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.project_vpc.id
    tags = { Name = "igw"}
}
resource "aws_route_table" "route_table" {
    vpc_id = aws_vpc.project_vpc.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw.id
    }
}
resource "aws_route_table_association" "rta1" {
    subnet_id      = aws_subnet.subnet1.id
    route_table_id = aws_route_table.route_table.id
}
resource "aws_route_table_association" "rta2" {
    subnet_id      = aws_subnet.subnet2.id
    route_table_id = aws_route_table.route_table.id
}

module "sgs" {
  source = "../eks_sg"
  vpc_id = aws_vpc.project_vpc.id
}

module "eks" {
  source = "../eks"
  vpc_id = aws_vpc.project_vpc.id
  subnet_ids = [aws_subnet.subnet1.id,aws_subnet.subnet2.id]
  sg_ids = module.sgs.security_group_public
}