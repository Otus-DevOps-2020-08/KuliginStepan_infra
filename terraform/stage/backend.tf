terraform {
  backend "s3" {
    endpoint = "storage.yandexcloud.net"
    bucket   = "outs-terraform-state"
    region   = "us-east-1"
    key      = "stage/terraform-state.tfstate"

    skip_region_validation      = true
    skip_credentials_validation = true
  }
}
