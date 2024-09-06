## Provider's Example

# Configure the AWS Provider
provider "aws" {
    version = "3.53.0"
    access_key = "AKIAR3HUOFMPFDV5VP7Y"
    secret_key = "MY_SECRET_KEY"
    region     = "us-east-1"
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
    version = "2.72.0"
    features {}
}
