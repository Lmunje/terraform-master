
resource "aws_key_pair" "lionel_key" {
    key_name = "lionel_key"
    public_key = file(var.PATH_TO_PUBLIC_KEY)
}

#Create AWS Instance
resource "aws_instance" "MyFirstInstnace" {
  ami           = lookup(var.AMIS, var.AWS_REGION)
  instance_type = "t2.micro"
  availability_zone = "us-east-1a"
  key_name      = aws_key_pair.lionel_key.key_name
  vpc_security_group_ids = [aws_security_group.allow-lionel-ssh.id]
  subnet_id = aws_subnet.lionelvpc-public-1.id

  tags = {
    Name = "custom_instance"
  }
}

output "public_ip" {
  value = aws_instance.MyFirstInstnace.public_ip 
}
