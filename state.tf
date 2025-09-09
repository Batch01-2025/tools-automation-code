terraform {
  backend "s3" {
    bucket = "batch01-tools"
    key    = "tools/terrform.tfstate"
    region = "us-east-1"
  }
}