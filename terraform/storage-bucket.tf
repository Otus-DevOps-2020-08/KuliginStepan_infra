resource "yandex_storage_bucket" "terraform-backend" {
  bucket = "outs-terraform-state"
}
