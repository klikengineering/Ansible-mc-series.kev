data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

}


/*
#data source for existing SG caliing a variable
data "aws_security_group" "selected" {
  id = var.security_group_id
}
*/


/*
#data source existing SGs using same tag to group them
data "aws_security_groups" "security_groups_managed_by_aws_console" {
  tags = {
    "managed-by" = "aws-console"
  }
}


/*
data "aws_ami" "example" {
  most_recent = true
  owners = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-ebs"]
  }
}
*/