module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.13.0"

  name = "vpc-module-demo"
  cidr = "10.0.0.0/16"

  azs             = slice(data.aws_availability_zones.available.names, 0, 2)
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = [
    "10.0.101.0/24",
    "10.0.102.0/24",
    "10.0.103.0/24",
    map(aws_subnet.public_subnet.* : { cidr = element(var.public_subnets, aws_subnet.public_subnet.value.cidr_block) }, { map_entries = true }) {
      map_key = title(cidr)
      availability_zone = data.aws_availability_zones.available.names[cidr]
      map_value {
        # Enable auto-assign public IP here
        map_key = "map_public_ip_on_launch"
        map_value = true
      }
    }
  ]

  enable_nat_gateway = false
  enable_vpn_gateway = false

  # Tags for Kubernetes, ensuring correct roles for ELB
  public_subnet_tags = {
    "kubernetes.io/role/elb" = "1"
  }

  private_subnet_tags = {
    "kubernetes.io/role/internal-elb" = "1"
  }

  tags = {
    Name = "${var.cluster-name}-vpc"
  }
}