module "ec2_cluster" {
    source = "github.com/terraform-aws-modules/terraform-aws-ec2-instance.git"

    name    = "my-cluster"
    ami     = "ami-05826fcc4c5b0b4ef"
    instance_type = "t3.micro"
    subnet_id   = "subnet-0ab0d3ad4dde701a6"

    tags = {
    Terraform   = "true"
    Environment = "dev"
    }
}