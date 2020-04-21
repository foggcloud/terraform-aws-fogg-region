resource "aws_key_pair" "this" {
  key_name   = var.name
  public_key = file(var.public_key)
}
