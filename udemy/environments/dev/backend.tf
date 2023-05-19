terraform {
  backend "s3" {
    bucket = "udemy-terraform-s3-20230516"
    key    = "dev/terraform.tfstate"
    region = "ap-northeast-1"
  }
}
