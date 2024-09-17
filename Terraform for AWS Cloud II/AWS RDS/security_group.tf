#Security Group for lionelvpc
resource "aws_security_group" "allow-lionel-ssh" {
  vpc_id      = aws_vpc.lionelvpc.id
  name        = "allow-lionel-ssh"
  description = "security group that allows ssh connection"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  tags = {
    Name = "allow-lionel-ssh"
  }
}

#Security Group for MariaDB
resource "aws_security_group" "allow-mariadb" {
  vpc_id      = aws_vpc.lionelvpc.id
  name        = "allow-mariadb"
  description = "security group for Maria DB"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    security_groups = [aws_security_group.allow-lionel-ssh.id]
  }
  
  tags = {
    Name = "allow-mariadb"
  }
}