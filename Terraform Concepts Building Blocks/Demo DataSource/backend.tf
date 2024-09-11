terraform {
    backend "s3" {
        bucket = "tf-state-98fty-01"
        key    = "development/terraform_state"
        region = "us-east-1"
    }
}


