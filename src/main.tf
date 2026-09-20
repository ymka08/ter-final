data "yandex_compute_image" "ubuntu" {
  family = "ubuntu-2204-lts"
}

resource "yandex_compute_instance" "web" {
  name        = "final-web"
  zone        = var.final_zone
  platform_id = "standard-v3"

  resources {
    cores         = var.vms_resources.web.cores
    memory        = var.vms_resources.web.memory
    core_fraction = var.vms_resources.web.core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.id
      size     = 10
      type     = "network-hdd"
    }
  }


  network_interface {
    subnet_id          = yandex_vpc_subnet.final_a.id
    ip_address         = "10.10.1.10"
    nat                = true
    security_group_ids = [yandex_vpc_security_group.final.id]
  }


  metadata = {
    ssh-keys           = "ubuntu:${file(var.ssh_public_key_path)}"
    serial-port-enable = "1"
    user-data = templatefile("${path.module}/cloud-init-web.yaml", {
      final_mysql_password = var.final_mysql_password
    })
  }

  scheduling_policy {
    preemptible = true
  }
}

resource "yandex_compute_instance" "db" {
  name        = "final-db"
  zone        = "ru-central1-b"
  platform_id = "standard-v3"

  resources {
    cores         = var.vms_resources.db.cores
    memory        = var.vms_resources.db.memory
    core_fraction = var.vms_resources.db.core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.id
      size     = 10
      type     = "network-hdd"
    }
  }


  network_interface {
    subnet_id          = yandex_vpc_subnet.final_b.id
    ip_address         = "10.10.2.10"
    nat                = true
    security_group_ids = [yandex_vpc_security_group.final.id]
  }


  metadata = {
    ssh-keys           = "ubuntu:${file(var.ssh_public_key_path)}"
    serial-port-enable = "1"
    user-data          = file("${path.module}/cloud-init-db.yaml")
  }

  scheduling_policy {
    preemptible = true
  }
}
