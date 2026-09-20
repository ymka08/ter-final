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
Задание 3

Для контейнеризации веб-приложения был создан файл `Dockerfile`.
В качестве базового образа используется `python:3.11-slim`. В контейнер копируется файл `final_app.py`, содержащий Flask веб-приложение. Устанавливается необходимая зависимость `Flask` и библиотека `PyMySQL` для подключения приложения к базе данных MySQL. Алогоритм работы я позадейтсовал из предыдущего ДЗ. Обращение к скрипту пишет в таблицу бд id, ip и timestamp обращения
Приложение запускается на 80 порту. Запуск контейнера выполняется командой `python final_app.py`.

 образ Docker для веб-приложения собирается и запускается на VM `final-web`. Для хранения Docker-образа в Yandex Cloud был создан Container Registry `final-registry` с помощью Terraform.
****************
Создаём файл registry.tf:

resource "yandex_container_registry" "final" {
  name      = "final-registry"
  folder_id = var.folder_id
}

Далее создаем контейнер 

<img width="1665" height="485" alt="image" src="https://github.com/user-attachments/assets/cce8b8ba-e65c-4fe8-b042-4d0eb8e799fa" />

и загружаем его в реестр , авторизуемся через ключ сервисного аккаунта 

<img width="1353" height="319" alt="image" src="https://github.com/user-attachments/assets/0b7df326-5d03-411a-9a6e-e443b4e81cc0" />

проверяем что наш образ попал в registry на YC

<img width="1834" height="443" alt="image" src="https://github.com/user-attachments/assets/aad3c4fa-efb8-466d-ac88-f64ed4d75ade" />
