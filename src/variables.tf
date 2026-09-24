variable "cloud_id" {
  type        = string
  description = "Yandex Cloud ID"
}

variable "folder_id" {
  type        = string
  description = "Yandex Cloud Folder ID"
}

variable "ssh_public_key_path" {
  type        = string
  description = "Path to SSH public key"
}

variable "final_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "Final availability zone"
}

variable "service_account_key_file" {
  type        = string
  description = "Path to service account key file"
}
################################

variable "vms_resources" {
  type = map(object({
    cores         = number
    memory        = number
    core_fraction = number
  }))
}

