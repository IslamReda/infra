resource "aws_vpc" "this" {
  cidr_block = var.cidr_block

  tags = {
    Name = "${var.name}-vpc"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.this.id

  tags = {
    Name = "${var.name}-igw"
  }
}

output "vpc_id" {
  value = aws_vpc.this.id
}

output "igw_id" {
  value = aws_internet_gateway.igw.id
}
