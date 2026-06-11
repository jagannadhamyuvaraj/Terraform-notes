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
 # Aws EC2
resource "aws_instance" "example" {
  instance_type = "t3.micro"
  ami           = "ami-0c6ac5f2fed2981b0" #amazon linux 2023
  region = local.region
  
  tags = {
    Environment = var.environment #input variable
    Name = "Dev-EC2-Instance"
  }
}
