# If user provided vpc_id/subnet_id, we'll use them; otherwise we will rely on default VPC/subnets.

resource "aws_security_group" "dev_sg" {
  name        = "${var.environment}-dev-sg"
  description = "Allow SSH and HTTP from office/dev team"
  vpc_id      = var.vpc_id != "" ? var.vpc_id : data.aws_vpc.default.id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # tighten to office IPs in production
  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(var.tags, {
    Name = "${var.environment}-dev-sg"
  })
}

data "aws_vpc" "default" {
  default = true
}

data "aws_subnet_ids" "default" {
  vpc_id = data.aws_vpc.default.id
}

module "ec2" {
  source        = "./modules/ec2-instance"
  instance_count = var.instance_count
  instance_type = var.instance_type
  ami           = var.ami
  key_name      = var.key_name
  subnet_id     = var.subnet_id != "" ? var.subnet_id : data.aws_subnet_ids.default.ids[0]
  security_group_ids = [aws_security_group.dev_sg.id]
  tags          = var.tags
}

