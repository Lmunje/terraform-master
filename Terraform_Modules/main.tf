module "ec2_cluster" {
    source = "github.com/terraform-aws-modules/terraform-aws-ec2-instance.git"

    name    = "my-cluster"
    ami     = "ami-04b3c39a8a1c62b76"
    instance_type          = "t2.micro"
    subnet_id   = "subnet-0ab0d3ad4dde701a6"

    tags = {
    Terraform   = "true"
    Environment = "dev"
    }
}