variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "environment" {
  type    = string
  default = "dev"
}

variable "instance_count" {
  description = "Number of t2.micro instances to create"
  type        = number
  default     = 1
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "ami" {
  description = "AMI ID to use for instances (Ubuntu 22.04 / Amazon Linux etc.)"
  type        = string
  default     = ""  # set in terraform.tfvars or via Jenkins param. Better to specify explicitly
}

variable "key_name" {
  description = "Key pair name to be used for SSH"
  type        = string
  default     = "your-keypair-name"
}

variable "vpc_id" {
  description = "VPC id; leave empty to create default resources"
  type        = string
  default     = ""
}

variable "subnet_id" {
  description = "Subnet id; leave empty to let provider choose"
  type        = string
  default     = ""
}

variable "tags" {
  type = map(string)
  default = {
    Owner       = "devops"
    ManagedBy   = "terraform"
  }
}
