#AWS ELB Configuration
resource "aws_elb" "lionel-elb" {
  name            = "lionel-elb"
  subnets         = [aws_subnet.lionelvpc-public-1.id, aws_subnet.lionelvpc-public-2.id]
  security_groups = [aws_security_group.lionel-elb-securitygroup.id]
  
  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:80/"
    interval            = 30
  }

  cross_zone_load_balancing   = true
  connection_draining         = true
  connection_draining_timeout = 400

  tags = {
    Name = "lionel-elb"
  }
}

#Security group for AWS ELB
resource "aws_security_group" "lionel-elb-securitygroup" {
  vpc_id      = aws_vpc.lionelvpc.id
  name        = "lionel-elb-sg"
  description = "security group for Elastic Load Balancer"
  
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "lionel-elb-sg"
  }
}

#Security group for the Instances
resource "aws_security_group" "lionel-instance" {
  vpc_id      = aws_vpc.lionelvpc.id
  name        = "lionel-instance"
  description = "security group for instances"
  
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

  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.lionel-elb-securitygroup.id]
  }

  tags = {
    Name = "lionel-instance"
  }
}