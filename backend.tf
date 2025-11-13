terraform {
  required_version = ">= 1.4"

  backend "s3" {
    bucket         = "my-terraform-state-bucket"   # create this before using
    key            = "dev-env/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-locks"             # create this table
    encrypt        = true
  }
}
