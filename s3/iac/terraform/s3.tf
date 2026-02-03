# Create an S3 bucket

resource "aws_s3_bucket" "terraform_s3_bucket" {

  tags = {
    Name        = "terraform-s3-bucket"
    Environment = "Dev"
  }
}