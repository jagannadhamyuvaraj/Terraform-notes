terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~>6.0"
    }
  }
  backend "s3" {
    bucket = "waiter-kb-logs"
    key    = "day-5/terraform.tfstate"
    region = "us-east-2"
    encrypt = true
    use_lockfile = true
  }
}

provider "aws" {
  region = "us-east-2"
}

# input variable
variable "environment" {
  default = "dev"
  type = string
}
variable "region" {
  default = "us-east-2"
}

locals {
  env = var.environment
  bucket_name = "terraform-bucket7733-${var.environment}"
  vpc_name = "${var.environment}-VPC"
  region = var.region
}


# create a s3 bucket
resource "aws_s3_bucket" "first_bucket764"{
  bucket = local.bucket_name
  region = local.region

  tags = {
    Name = local.bucket_name
    Environment = "var.environment"
  }
}

resource "aws_vpc" "yuvaraj-vpc" {
  cidr_block = "10.0.1.0/24"
  region = local.region

  tags = {
    #Name = "sample_vpc"
    Environment = "var.environment"
    Name = local.vpc_name
  }
}

resource "aws_instance" "example" {
  instance_type = "t3.micro"
  ami           = "ami-0c6ac5f2fed2981b0" #amazon linux 2023
  region = local.region
  
  tags = {
    Environment = "var.environment" #input variable
    Name = "Dev-EC2-Instance"
  }
}
