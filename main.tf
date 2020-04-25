resource "aws_key_pair" "this" {
  key_name   = var.name
  public_key = file(var.public_key)
}

resource "aws_default_vpc" "default" {
  tags = {
    Name      = "default"
    ManagedBy = "Terraform"
  }
}

resource "aws_default_security_group" "default" {
  vpc_id = aws_default.vpc.default.id

  tags = {
    Name      = "default"
    ManagedBy = "Terraform"
  }
}
