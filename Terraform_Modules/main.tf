module "ec2_cluster" {
    source = "github.com/terraform-aws-modules/terraform-aws-ec2-instance.git"

    name    = "my-cluster"
    ami     = "ami-07e1435a5f65279ec"
    instance_type          = "t2.micro"
    subnet_id   = "subnet-0ab0d3ad4dde701a6"

    tags = {
    Terraform   = "true"
    Environment = "dev"
    }
}