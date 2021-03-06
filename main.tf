# Setting a Provider information and authentication profile
provider "aws" {
  region                  = "us-east-1"
  shared_credentials_file = "/home/ec2-user/.aws/credentials"
  profile                 = "default"
}

provider "mysql" {
  endpoint = aws_db_instance.sunny_db.endpoint
  username = aws_db_instance.sunny_db.username
  password = data.aws_ssm_parameter.rds_master_password.value
}

terraform {

  backend "s3" {
    bucket = "sunbit-interview"
    key    = "environment/terraform.tfstate"
    region = "us-east-1"
  }

  required_providers {

    mysql = {
      source  = "winebarrel/mysql"
      version = "1.10.6"
    }

    http = {
      source  = "hashicorp/http"
      version = "2.1.0"
    }
  }
}
