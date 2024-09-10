variable "AWS_ACCESS_KEY" {
    type = string
    default = "AKIAR3HUOFMPFDV5VP7Y"
}

variable "AWS_SECRET_KEY" {}

variable "AWS_REGION" {
default = "us-east-1"
}

# Define Security Groups (as a list of strings)
variable "Security_Group" {
  type = list(string)
  default = ["sg-24076", "sg-90890", "sg-456789"]
}

# Define AMIs (as a map of region to AMI ID)
variable "AMIS" {
  type = map(string)
  default = {
    us-east-1 = "ami-09e67e426f25ce0d7"
    us-east-2 = "ami-0a0bc3bd5fe28b7e4"
    us-west-1 = "ami-03d315ad33b9d49c4"
    us-west-2 = "ami-03d5c68bab01f3496"
  }
}

variable "PATH_TO_PRIVATE_KEY" {
  default = "levelup_key"
}

variable "PATH_TO_PUBLIC_KEY" {
  default = "levelup_key.pub"
}

variable "INSTANCE_USERNAME" {
  default = "ubuntu"
}


