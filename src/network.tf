resource "yandex_vpc_network" "final" {
  name = "final-network"
}

resource "yandex_vpc_subnet" "final_a" {
  name           = "final-subnet-a"
  zone           = var.final_zone
  network_id     = yandex_vpc_network.final.id
  v4_cidr_blocks = ["10.10.1.0/24"]
}

resource "yandex_vpc_subnet" "final_b" {
  name           = "final-subnet-b"
  zone           = "ru-central1-b"
  network_id     = yandex_vpc_network.final.id
  v4_cidr_blocks = ["10.10.2.0/24"]
}
