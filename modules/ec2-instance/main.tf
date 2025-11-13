variable "instance_count" { type = number }
variable "instance_type"  { type = string }
variable "ami"            { type = string }
variable "key_name"       { type = string }
variable "subnet_id"      { type = string }
variable "security_group_ids" { type = list(string) }
variable "tags"           { type = map(string) }

resource "aws_instance" "dev" {
  count         = var.instance_count
  ami           = var.ami
  instance_type = var.instance_type
  subnet_id     = var.subnet_id
  vpc_security_group_ids = var.security_group_ids
  key_name      = var.key_name

  user_data = file("${path.module}/../../user_data.sh")

  tags = merge(var.tags, {
    Name = "${var.instance_type}-${count.index + 1}"
  })
}
