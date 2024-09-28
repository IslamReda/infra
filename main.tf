provider "aws" {
  region = var.aws_region
}

terraform {
  backend "s3" {
    bucket         = var.s3_bucket
    key            = "terraform/state"
    region         = var.aws_region
    encrypt        = true
    dynamodb_table = var.dynamodb_table
  }
}

module "vpc" {
  source     = "./modules/vpc"
  cidr_block = var.vpc_cidr
  name       = "main"
}

module "public_subnet" {
  source     = "./modules/subnet"
  vpc_id     = module.vpc.vpc_id
  cidr_block = var.public_subnet_cidr
  name       = "public-subnet"
  public     = true
  gateway_id = module.vpc.igw_id
}

module "private_subnet" {
  source     = "./modules/subnet"
  vpc_id     = module.vpc.vpc_id
  cidr_block = var.private_subnet_cidr
  name       = "private-subnet"
  public     = false
}

module "public_instance" {
  source        = "./modules/ec2"
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = module.public_subnet.subnet_id
  vpc_id        = module.vpc.vpc_id
  name          = "public-instance"
}

module "private_instance" {
  source        = "./modules/ec2"
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = module.private_subnet.subnet_id
  vpc_id        = module.vpc.vpc_id
  name          = "private-instance"
}
