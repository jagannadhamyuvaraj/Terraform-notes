- Whenever you have to use certain values again and again in a file, program, or script, you have to type the value again and again

- We define a variable block with a name, a default value, and an optional type. By replacing hard-coded values with reference to the variable, we can update the value in one place, and it reflects everywhere

```
        resource "aws_s3_bucket" "terraform-bucket7733"{
       bucket = "terraform-bucket7733"

       tags = {
       Name = "yuvaraj"
       Environment = "dev"
       }
    }

    resource "aws_vpc" "yuvaraj-vpc" {
      cidr_block = "10.0.1.0/24"

      tags = {
      #Name = "sample_vpc"
      Environment = "Dev"
      Name = "Dev-VPC"
     }
    }

    resource "aws_instance" "example" {
     instance_type = "t2.micro"
  
     tags = {
     Ennvironment = "Dev"
     Name = "Dev-EC2-Instance"
     }
    }

```



 using this particular field <b>environment</b> = <b>dev</b> over here in S3 bucket. Same thing over here in AWS VPC and same thing over here in EC2 instance. There could be hundreds of more resources which will have the same tag and we have to initialize it again and again with the same value

 - when we are using this file we'll be using it for multiple environments so if I have to make it from dev to stage I have to do it in every single resource, right?

```             
     variable "environment" {
       default = "dev"
       type = string
     }
     
     #create a s3 bucket
    resource "aws_s3_bucket" "terraform-bucket7733"{
     bucket = "terraform-bucket7733"

     tags = {
     Name = "yuvaraj"
     Environment = "var.environment"
     }
    }

     resource "aws_vpc" "yuvaraj-vpc" {
       cidr_block = "10.0.1.0/24"

     tags = {
      #Name = "sample_vpc"
      Environment = "var.environment"
      Name = "Dev-VPC"
      }
    }

    resource "aws_instance" "example" {
      instance_type = "t2.micro"
  
     tags = {
      Ennvironment = "var.environment"
      Name = "Dev-EC2-Instance"
     }
     }
  ```

- In the variable section we define var = env and use it in the subsequent fields in the of resource. Here we are accessing the local name of the varaible (environment) not the actual value (default = "dev").

- Actual value may change to "stage" or "prod", we are accesing the local name of the variable

# Local varaibles
 
 - Internal computed values - like local variables in programming.

 - They allow us to assign a name to an expression or a value, which you can then reuse multiple times throughout your configuration.

- Local variables are defined inside a locals block. Unlike input variables, you do not define types (string, number, etc.) or default values for them—Terraform automatically infers the type based on the value you assign.

- So using variable over here is first you need to create dollar sign and this is how we create the variable. So you see dollar and dollar after dollar sign we have the curly braces.

        ${local.name}

- Why do we need that? Because earlier we were just accessing it with var.environment ?
  
    **  it's string concatenation that we are doing right. We are first we need to resolve the value of this variable and then add it to hyphen **

```
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
    # create a vpc
    resource "aws_vpc" "yuvaraj-vpc" {
    cidr_block = "10.0.1.0/24"
    region = local.region

     tags = {
    #Name = "sample_vpc"
    Environment = "var.environment"
    Name = "local.vpc_name"
     }
    }

    resource "aws_instance" "example" {
    instance_type = "t2.micro"
    region = local.region
  
    tags = {
    Environment = "var.environment" #input variable
    Name = "Dev-EC2-Instance"
     }
    }

```

- Here in the variables section we create a variables along with their name and use it in the local variable section.

- The locals are used in the resources section

- when referencing local variable do not use " " between them
 HEAD

# locals variables in Terraform

  Local variables are used inside the tf files that does not have global access

```
           locals {
           env = var.environment
           bucket_name = "terraform-bucket7733-${var.environment}"
           vpc_name = "${var.environment}-VPC"
           region = var.region
           }

```

# Variables precedence in the Terraform 

  <li>
Terraform uses the following order of precedence:

<ul>Any -var and -var-file options on the command line in the order provided and variables from HCP Terraform</ul>
<ul>Any *.auto.tfvars or *.auto.tfvars.json files in lexical order</ul>
<ul>The terraform.tfvars.json file</ul>
<ul>The terraform.tfvars file</ul>
<ul>Environment variables</ul>
<ul>The default argument of the variable block</ul>
   
   
  </li>    


