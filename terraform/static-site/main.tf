terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
 
}
resource "aws_instance" "my_inst" {
    ami = "ami-007855ac798b5175e"
    instance_type="t2.micro"
    key_name="epamkey"
    vpc_security_group_ids = ["sg-053a16f49a2aeb034","sg-00cdf3d5e989315b0"]
        tags = {
           Name="my_instance"
           group="tag_group_web"
        }
}
