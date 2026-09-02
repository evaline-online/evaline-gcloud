# Звіт щодо архітектури серверів Evaline та налаштування доменів

## Огляд статусу

- **Обліковий запис**: `evabot.online@gmail.com`
- **Активний проєкт GCP**: `evabot-agent-server`
- **Вузли (VM)**:
  - `evaline-micro-vm` (Мікросервер, `e2-micro`, `us-central1-a`, Зовнішня IP: `136.114.26.252`)
  - `evabot-agent-vm` (`c3-standard-8`, `europe-west3-a`, Зовнішня IP: `34.179.253.183`)

## Розгорнуті сервіси на мікросервері (`evaline-micro-vm`)

1. **Вебсервер**: Caddy (Служба systemd `caddy.service`)
2. **Поточні підключені домени**:
   - `evabot.online` -> `/var/www/evabot.online`
   - `www.evabot.online` -> `/var/www/evabot.online`

## Підключення нових доменів до однойменних папок

Щоб підключити додаткові домени (наприклад, `domain2.com`) до папок із відповідними назвами (`/var/www/domain2.com`):

1. **Налаштування DNS**: Спрямуйте A-запис домену на IP сервера `136.114.26.252`.
2. **Створення каталогу**:
   ```bash
   sudo mkdir -p /var/www/domain2.com
   sudo chown -R www-data:www-data /var/www/domain2.com
   ```
3. **Конфігурація Caddy (`/etc/caddy/Caddyfile`)**:
   ```caddy
   domain2.com, www.domain2.com {
       root * /var/www/domain2.com
       file_server
   }
   ```
4. **Перезапуск вебсервера**:
   ```bash
   sudo systemctl reload caddy
   ```
