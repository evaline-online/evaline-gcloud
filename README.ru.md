# Настройка проекта Evaline в Google Cloud

Этот репозиторий содержит скрипты управления, документацию и конфигурацию для среды **Evaline** в Google Cloud Platform (`evabot.online@gmail.com`).

## Обзор

- **Аккаунт**: `evabot.online@gmail.com`
- **Идентификатор проекта**: `evabot-agent-server`
- **Основной регион / зона**: `europe-west3` / `europe-west3-b`
- **Основной сервер**: `evaline-server-001`

## Использование

```bash
./setup-gcloud.sh install    # Установка только gcloud CLI
./setup-gcloud.sh connect    # Авторизация и подключение по SSH
```

## Переменные окружения

| Переменная | Значение по умолчанию | Описание |
|---|---|---|
| `VM_NAME` | `evaline-server-001` | Имя виртуальной машины Compute Engine |
| `ZONE` | `europe-west3-b` | Зона GCP Compute Engine |
| `SSH_USER` | `fedor` | Имя пользователя SSH |
| `PROJECT` | `evabot-agent-server` | Идентификатор проекта GCP |

## Параллельная документация

- [English Documentation](file:///home/fedor/Desktop/evaline-gcloud/README.en.md)
- [Русская документация](file:///home/fedor/Desktop/evaline-gcloud/README.ru.md)
- [Українська документація](file:///home/fedor/Desktop/evaline-gcloud/README.uk.md)
