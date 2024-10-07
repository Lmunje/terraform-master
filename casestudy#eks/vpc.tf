module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.13.0"

  name = "vpc-module-demo"
  cidr = "10.0.0.0/16"

  # Availability zones
  azs = slice(data.aws_availability_zones.available.names, 0, 2)

  # Subnets
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

  # Enable auto-assign public IP for public subnets
  public_subnet_tags = {
    "kubernetes.io/role/elb"  = "1"  # For Kubernetes ELB role
    "map_public_ip_on_launch" = "true"
  }

  # Tags for private subnets for internal load balancers
  private_subnet_tags = {
    "kubernetes.io/role/internal-elb" = "1"
  }

  # Disable NAT and VPN gateways
  enable_nat_gateway = false
  enable_vpn_gateway = false

  tags = {
    Name = "${var.cluster-name}-vpc"
  }
}
