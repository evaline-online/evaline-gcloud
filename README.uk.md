# Налаштування проєкту Evaline в Google Cloud

Цей репозиторій містить скрипти управління, документацію та конфігурацію для середовища **Evaline** у Google Cloud Platform (`evabot.online@gmail.com`).

## Огляд

- **Обліковий запис**: `evabot.online@gmail.com`
- **Ідентифікатор проєкту**: `evabot-agent-server`
- **Основний регіон / зона**: `europe-west3` / `europe-west3-b`
- **Основний сервер**: `evaline-server-001`

## Використання

```bash
./setup-gcloud.sh install    # Установка тільки gcloud CLI
./setup-gcloud.sh connect    # Авторизація та підключення через SSH
```

## Змінні оточення

| Змінна | Значення за замовчуванням | Опис |
|---|---|---|
| `VM_NAME` | `evaline-server-001` | Назва віртуальної машини Compute Engine |
| `ZONE` | `europe-west3-b` | Зона GCP Compute Engine |
| `SSH_USER` | `fedor` | Ім'я користувача SSH |
| `PROJECT` | `evabot-agent-server` | Ідентифікатор проєкту GCP |

## Паралельна документація

- [English Documentation](file:///home/fedor/Desktop/evaline-gcloud/README.en.md)
- [Русская документация](file:///home/fedor/Desktop/evaline-gcloud/README.ru.md)
- [Українська документація](file:///home/fedor/Desktop/evaline-gcloud/README.uk.md)
