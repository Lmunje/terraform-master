module "ec2_cluster" {
    source = "github.com/terraform-aws-modules/terraform-aws-ec2-instance.git"

    name    = "my-cluster"
    ami     = "ami-0c55b159cbfafe1f0"
    instance_type          = "t2.micro"
    subnet_id   = "subnet-0ab0d3ad4dde701a6"

    tags = {
    Terraform   = "true"
    Environment = "dev"
    }
}