variable "aws_region" {
  type    = string
  default = "us-west-2"
}

variable "my_instance_type" {
  type    = string
  default = "t2.micro"
}

variable "my_instance_type-ub" {
  type    = string
  default = "t2.medium"
}

variable "security-group" {
  type = set(string)
  default = ["webserver3 Sg"]
  
}

#variable for existing SG
variable "security_group_id" {
  type    = string
  default = "sg-0d7749dea35961abc"
} 
variable "my_key" {
  type    = string
  default = "ansible"
}

variable "os" {
  type = string
  #default = "linux"
}