#Create AWS S3 Bucket

resource "aws_s3_bucket" "lionel-s3bucket" {
  bucket = "lionel-bucket-141"
  acl    = "private"

  tags = {
    Name = "lionel-bucket-141"
  }
}

