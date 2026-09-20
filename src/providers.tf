terraform {
  required_version = "~> 1.12"

  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "~> 0.150"
    }
  }
}

provider "yandex" {
  cloud_id                 = var.cloud_id
  folder_id                = var.folder_id
  zone                     = var.final_zone
  service_account_key_file = var.service_account_key_file
}
