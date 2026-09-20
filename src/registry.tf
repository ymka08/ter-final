resource "yandex_container_registry" "final" {
  name      = "final-registry"
  folder_id = var.folder_id
}
