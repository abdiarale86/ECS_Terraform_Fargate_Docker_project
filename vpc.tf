#-------Create VPC for ECS

resource "aws_vpc" "Abdi-ECS-project" {
  cidr_block = var.cidr

  tags = {
    Name = "Project ECS"
  }
}

#Private subnets for ECS

resource "aws_subnet" "private_east_a" {
  vpc_id            = aws_vpc.Abdi-ECS-project.id
  cidr_block        = var.private_cidr_a
  availability_zone = var.region_a

  tags = {
    Name = "Private East A"
  }
}

resource "aws_subnet" "private_east_b" {
  vpc_id            = aws_vpc.Abdi-ECS-project.id
  cidr_block        = var.private_cidr_b
  availability_zone = var.region_a

  tags = {
    Name = "Private East B"
  }
}
