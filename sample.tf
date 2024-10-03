terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.67.0"
    }
  }
}

provider "aws" {
  # Configuration options

}
resource "aws_vpc" "base" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "aws-vpc"
  }

}
