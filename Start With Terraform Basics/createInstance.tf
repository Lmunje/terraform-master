
resource "aws_instance" "MyFirstInstnace" {
  count         = 3
  ami           = "ami-05803413c51f242b7"
  instance_type = "t4g.micro"
}

