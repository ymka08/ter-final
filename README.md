# ter-final








Обявление путей для всех обьявленых переменных паролей и ключей

export TF_VAR_cloud_id="$(cat ~/cloud_id)"
export TF_VAR_folder_id="$(cat ~/folder_id)"
export TF_VAR_ssh_public_key_path="$HOME/ssh-key-ymka-vm-toolbox.pub"
export TF_VAR_service_account_key_file="$HOME/.service_study_authorized_key.json"
####export TF_VAR_service_account_key_file="/home/ymka/.service_study_authorized_key.json"


######################

Создание БД MySQL в Yandex Cloud

Для размещения БД создаётся виртуальная машина final-db в YC. В качестве ОС используется Ubuntu 22.04.
VM размещается в зоне ru-central1-b и подключается к подсети final-subnet-b 10.10.2.0/24.
Параметры виртуальной машины:
2 CPU
1 ГБ
10Гб 
прерываемая 
ОС Ubuntu 22.04
публичный IP-адрес включён для возможности подключения к VM по SSH
SSH-ключ передаётся через metadata.
Установка MySQL выполняется автоматически при первом запуске VM с помощью cloud-init-db.yaml

после создания final-db автоматически:
1.запускается Ubuntu 
2.сloud-Init устанавливает пакеты
3.устанавливается mysql-server, MySQL добавляется в автозапуск и запускается.


#######################

Создание Container Registry

Для хранения Docker-образов создаётся Container Registry в YC с помощью Terraform.

Создаём файл registry.tf:

resource "yandex_container_registry" "final" {
  name      = "final-registry"
  folder_id = var.folder_id
}

Здесь:

yandex_container_registry — ресурс Container Registry Yandex Cloud;
name = "final-registry" — имя реестра;
folder_id = var.folder_id — реестр создаётся в текущем каталоге Yandex Cloud, без жёстко заданного ID.

После создания Registry в него можно будет загружать Docker-образы проекта и затем использовать их при развёртывании приложения.
