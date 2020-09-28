provider "yandex" {
  service_account_key_file = var.service_account_key_file
  cloud_id                 = var.cloud_id
  folder_id                = var.folder_id
  zone                     = var.zone
}

data "yandex_compute_image" "reddit" {
  name = "reddit-base-1601118897"
}

data "yandex_vpc_subnet" "default-subnet" {
  name = "default-ru-central1-a"
}

resource "yandex_compute_instance" "app" {
  count = var.app_count
  name  = "reddit-app-${count.index}"
  zone  = var.app_zone
  resources {
    cores         = 2
    core_fraction = 5
    memory        = 2
  }
  metadata = {
    ssh-keys = "ubuntu:${file(var.public_key_path)}}"
  }
  boot_disk {
    initialize_params {
      image_id = var.image_id
    }
  }
  network_interface {
    subnet_id = var.subnet_id
    nat       = true
  }
  connection {
    type  = "ssh"
    host  = self.network_interface.0.nat_ip_address
    user  = "ubuntu"
    agent = false
    # путь до приватного ключа
    private_key = file(var.private_key_path)
  }
  provisioner "file" {
    source      = "files/puma.service"
    destination = "/tmp/puma.service"
  }
  provisioner "remote-exec" {
    script = "files/deploy.sh"
  }
}