variable "region" {
  default = "us-east-1"
}

variable "public_key_path" {
  description = "Public key path"
  default = "~/.ssh/lionel_key.pub"
}

variable "instance_ami" {
  description = "AMI for aws EC2 instance"
  default = "ami-08c40ec9ead489470"
}

variable "instance_type" {
  description = "type for aws EC2 instance"
  default = "t2.micro"
}

variable "environment_tag" {
  description = "Environment tag"
  default = "Production"
}
