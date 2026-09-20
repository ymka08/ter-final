# ter-final
небольшое замечание по безопасности: 
все ключи подгружаются через обявление путей переменных на моей учебной VM

export TF_VAR_cloud_id="$(cat ~/cloud_id)"

export TF_VAR_folder_id="$(cat ~/folder_id)"

export TF_VAR_ssh_public_key_path="$HOME/ssh-key-ymka-vm-toolbox.pub"

export TF_VAR_service_account_key_file="$HOME/.service_study_authorized_key.json"

но данные для БД остались в открытом виде в cloud файле бд для наглядности  

Результат создания двух VM и подстетей с получением внешних ip доступом по через 80 порт в скриншотах:

<img width="1850" height="140" alt="image" src="https://github.com/user-attachments/assets/e3d60abc-0cdb-4fc7-865e-167c0a9999f1" />


<img width="1204" height="586" alt="image" src="https://github.com/user-attachments/assets/49fca07d-98f4-44f4-97ea-8fa443f429fb" />

заходим на web и смотрим работающий контенер слушающий на 80 порту

<img width="1138" height="78" alt="image" src="https://github.com/user-attachments/assets/5e37ab74-2742-4550-a921-67058bad18d1" />

резуьтат обращения через публичный ip и с локальной машины curl http://localhost Request received

<img width="749" height="246" alt="image" src="https://github.com/user-attachments/assets/186f5ccd-483a-408f-ab0a-bd38865dbc7a" />

Результаты записей в базу данных смотрите ниже


######################

Задание 1

Создание БД MySQL в YC
База данных MySQL была развернута на отдельной виртуальной машине `final-db` на Ubuntu 22.04 в подсети `10.10.2.0/24`. При создании ВМ с помощью `cloud-init` автоматически устанавливался MySQL Server и выполнялась его настройка.
MySQL настроен на приём внешних подключений на порту `3306`. Для обращения из web приложения был создан пользователь `final` с правами на базу данных `final_db` и таблица `requests` со полями: `id`, `ip` и `time`.
Доступ к MySQL разрешён через Security Group на порт `3306`. В результате веб-приложение, запущенное в Docker на ВМ `final-web`, успешно подключается к MySQL на `final-db` и записывает полученные запросы в базу данных.

<img width="860" height="71" alt="image" src="https://github.com/user-attachments/assets/563d7222-504f-4fab-9919-4b052425a49e" />

<img width="741" height="534" alt="image" src="https://github.com/user-attachments/assets/b2fc63f5-7e7b-497b-af9f-0521265a7a59" />


Записи обращений в БД

<img width="886" height="228" alt="image" src="https://github.com/user-attachments/assets/263d3a87-8284-4585-993c-1e33b4b5bbc5" />



#######################

Задание 3

Для контейнеризации веб-приложения был создан файл `Dockerfile`.
В качестве базового образа используется `python:3.11-slim`. В контейнер копируется файл `final_app.py`, содержащий Flask веб-приложение. Устанавливается необходимая зависимость `Flask` и библиотека `PyMySQL` для подключения приложения к базе данных MySQL. Алогоритм работы я позадейтсовал из предыдущего ДЗ. Обращение к скрипту пишет в таблицу бд id, ip и timestamp обращения
Приложение запускается на 80 порту. Запуск контейнера выполняется командой `python final_app.py`.

 образ Docker для веб-приложения собирается и запускается на VM `final-web`. Для хранения Docker-образа в Yandex Cloud был создан Container Registry `final-registry` с помощью Terraform.
****************
Создание Container Registry
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
