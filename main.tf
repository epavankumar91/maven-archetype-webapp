resource "aws_s3_bucket" "b" {
  bucket = "devopsin60min_test_bkt"
  acl    = "private"

  versioning {
    enabled = true
  }
}
