data "aws_caller_identity" "this" {
}

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
  vpc_id = aws_default_vpc.default.id

  tags = {
    Name      = "default"
    ManagedBy = "Terraform"
  }
}

resource "aws_kms_grant" "asg_ami" {
  name              = format("%s-%s", "asg-ami", terraform.workspace)
  key_id            = var.ami_kms_key_id
  grantee_principal = format("arn:aws:iam::%s:role/aws-service-role/autoscaling.amazonaws.com/AWSServiceRoleForAutoScaling", data.aws_caller_identity.this.account_id)
  operations        = ["Encrypt", "Decrypt", "ReEncryptFrom", "ReEncryptTo", "GenerateDataKey", "GenerateDataKeyWithoutPlaintext", "DescribeKey", "CreateGrant"]
}
