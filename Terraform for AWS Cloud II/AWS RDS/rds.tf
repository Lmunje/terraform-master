# RDS Resources
resource "aws_db_subnet_group" "mariadb-subnets" {
  name        = "mariadb-subnets"
  description = "Amazon RDS subnet group"
  subnet_ids  = [aws_subnet.lionelvpc-private-1.id, aws_subnet.lionelvpc-private-2.id]
}

# RDS Parameters
resource "aws_db_parameter_group" "lionel-mariadb-parameters" {
  name        = "lionel-mariadb-parameters"
  family      = "mariadb10.6"  # Use family corresponding to the engine version
  description = "MariaDB parameter group"

  parameter {
    name  = "max_allowed_packet"
    value = "16777216"
  }
}

# RDS Instance properties
resource "aws_db_instance" "lionel-mariadb" {
  allocated_storage       = 20             # 20 GB of storage
  engine                  = "mariadb"
  engine_version          = "10.6"         # Switch to a more widely supported version
  instance_class          = "db.t3.micro"  # Use t3.micro for compatibility
  identifier              = "mariadb"
  db_name                 = "mariadb"
  username                = "root"         # Username
  password                = "mariadb141"   # Password
  db_subnet_group_name    = aws_db_subnet_group.mariadb-subnets.name
  parameter_group_name    = aws_db_parameter_group.lionel-mariadb-parameters.name
  multi_az                = "false"        # Single AZ for cost-saving
  vpc_security_group_ids  = [aws_security_group.allow-mariadb.id]
  storage_type            = "gp2"
  backup_retention_period = 30             # 30-day backup retention
  availability_zone       = aws_subnet.lionelvpc-private-1.availability_zone
  skip_final_snapshot     = true           # Skip final snapshot during destroy
  
  tags = {
    Name = "lionel-mariadb"
  }
}

output "rds" {
  value = aws_db_instance.lionel-mariadb.endpoint
}
