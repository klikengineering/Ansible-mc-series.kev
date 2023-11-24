#resource block
resource "aws_instance" "ubuntu" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.my_instance_type-ub
  #security_groups = var.security-group
  #user_data     = file("${path.module}/ansible-install-ubuntu.sh")
  user_data = data.template_cloudinit_config.user-data.rendered

  key_name = var.my_key

  tags = {
    "Name" = "Ansible-Ubuntu"
  }
}

resource "aws_instance" "ubuntu-hosts" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.my_instance_type
  #security_groups = var.security-group
  user_data     = file("${path.module}/create_ansible_user.sh")
  key_name      = var.my_key
  count         = 2
  tags = {
    "Name" = "My-Ubuntu-ansible-host-${count.index}"
    "Type" = "My-Ubuntu-${count.index}"
  }
}

resource "aws_instance" "rhel-hosts" {
  ami           = data.aws_ami.rhel.id
  instance_type = var.my_instance_type
  #security_groups = var.security-group
  user_data     = file("${path.module}/create_ansible_user.sh")
  key_name      = var.my_key
  count         = 1
  tags = {
    "Name" = "My-rhel-ansible-host-${count.index}"
  }
}


data "template_cloudinit_config" "user-data" {
  part {
    content_type = "text/x-shellscript"
    content      = file("${path.module}/ansible-install-ubuntu.sh")
  }
  part {
    content_type = "text/x-shellscript"
    content      = file("${path.module}/vscode-install.sh")
  }
}

/*
#add rules to SG
resource "aws_security_group_rule" "allow_ssh_from_vpc" {
 type              = "ingress"
 description       = "Allow SSH from VPC"
 from_port         = 22
 to_port           = 22
 protocol          = "tcp"
 cidr_blocks       = [data.aws_vpc.default.cidr_block]
 security_group_id = data.aws_security_group.selected.id

}
*/

/* 
#Modify the existing inbound SSH rule that we created earlier to add this rule to 
#all the matching security groups. We will use the for_each meta tag to achieve this. 
#Optionally, add the output to print all the matching security group ids.
 resource "aws_security_group_rule" "allow_ssh_from_vpc" {
 for_each          = toset(data.aws_security_groups.security_groups_managed_by_aws_console.ids)
 type              = "ingress"
 description       = "Allow SSH from VPC"
 from_port         = 22
 to_port           = 22
 protocol          = "tcp"
 cidr_blocks       = [data.aws_vpc.default.cidr_block]
 security_group_id = each.value
}
*/

