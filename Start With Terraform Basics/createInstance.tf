
provider "aws" {
  access_key = "AKIAR3HUOFMPCEHFMWVB"
  secret_key = "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"
  region =  "us-east-2"
}

resource "aws_instance" "MyFirstInstnace" {
  count         = 3
  ami           = "ami-05803413c51f242b7"
  instance_type = "t4g.micro"
}

