# Отчёт по архитектуре серверов Evaline и настройке доменов

## Обзор статуса

- **Аккаунт**: `evabot.online@gmail.com`
- **Активный проект GCP**: `evabot-agent-server`
- **Узлы (VM)**:
  - `evaline-micro-vm` (Микросервер, `e2-micro`, `us-central1-a`, Внешний IP: `136.114.26.252`)
  - `evabot-agent-vm` (`c3-standard-8`, `europe-west3-a`, Внешний IP: `34.179.253.183`)

## Развёрнутые сервисы на микросервере (`evaline-micro-vm`)

1. **Веб-сервер**: Caddy (Служба systemd `caddy.service`)
2. **Текущие привязанные домены**:
   - `evabot.online` -> `/var/www/evabot.online`
   - `www.evabot.online` -> `/var/www/evabot.online`

## Подключение новых доменов к одноимённым папкам

Чтобы подключить дополнительные домены (например, `domain2.com`) к папкам с аналогичными названиями (`/var/www/domain2.com`):

1. **Настройка DNS**: Направьте A-запись домена на IP сервера `136.114.26.252`.
2. **Создание каталога**:
   ```bash
   sudo mkdir -p /var/www/domain2.com
   sudo chown -R www-data:www-data /var/www/domain2.com
   ```
3. **Конфигурация Caddy (`/etc/caddy/Caddyfile`)**:
   ```caddy
   domain2.com, www.domain2.com {
       root * /var/www/domain2.com
       file_server
   }
   ```
4. **Перезапуск веб-сервера**:
   ```bash
   sudo systemctl reload caddy
   ```

