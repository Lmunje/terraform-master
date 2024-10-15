provider "google" {
    credentials = file("terraform-with-gcp-438621-b4ead1b290f2.json")

    project = "terraform-with-gcp-438621"
    region  = "us-east1"
    zone    = "us-east1-c"
}

resource "google_compute_network" "vpc_network" {
    name                    = "practice-network"
    auto_create_subnetworks = "true"
}

terraform {
  backend "gcs" {
    bucket  = "lionel-terraform"
    prefix  = "lionel-terraform/terraform-sample-practice"
    credentials = "terraform-with-gcp-438621-b4ead1b290f2.json"
  }
}