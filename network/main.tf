#### Create a backend to save the state file###########

terraform {
  backend "s3" {
    bucket = "jaitfstate"
    key    = "network/network.tfstate"
    region = "us-east-2"
  }
}

resource "aws_vpc" "vpc1" {
  cidr_block       = var.cidr
  instance_tenancy = "default"

  tags = {
    Name = var.name
  }
}

resource "aws_subnet" "public" {
  vpc_id     = aws_vpc.vpc1.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "jaipub1"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.vpc1.id

  tags = {
    Name = "jaigw"
  }
}

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.public.id
  route_table_id = "rtb-08524420bef4f73b7"
}



resource "aws_route" "r" {
  route_table_id            = "rtb-08524420bef4f73b7"
  destination_cidr_block    = "0.0.0.0/0"
  gateway_id                = aws_internet_gateway.gw.id
}