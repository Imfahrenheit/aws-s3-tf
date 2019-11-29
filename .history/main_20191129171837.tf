# Require TF version to be same as or greater than 0.12.13
terraform {
  required_version = ">=0.12.13"
  #backend "s3" {
  #  bucket         = "s3-terraform-storage"
  #  key            = "terraform.tfstate"
  #  region         = "u-north-1"
  #  dynamodb_table = "aws-locks"
  #  encrypt        = true
  #}
}

# Download any stable version in AWS provider of 2.36.0 or higher in 2.36 train
provider "aws" {
  region  = "eu-north-1"
  version = "~> 2.36.0"
}

# Call the seed_module to build our ADO seed info
module "bootstrap" {
  source                      = "./modules/bootstrap"
  name_of_s3_bucket           = "s3-terraform-storage"
  dynamo_db_table_name        = "aws-locks"
  iam_user_name               = "IamUser"
  ado_iam_role_name           = "IamRole"
  aws_iam_policy_permits_name = "IamPolicyPermits"
  aws_iam_policy_assume_name  = "IamPolicyAssume"
}
