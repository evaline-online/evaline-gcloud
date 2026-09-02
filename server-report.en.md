# Evaline Server Architecture & Domain Setup Report

## Status Overview

- **Account**: `evabot.online@gmail.com`
- **Active GCP Project**: `evabot-agent-server`
- **Nodes**:
  - `evaline-micro-vm` (Microserver, `e2-micro`, `us-central1-a`, External IP: `136.114.26.252`)
  - `evabot-agent-vm` (`c3-standard-8`, `europe-west3-a`, External IP: `34.179.253.183`)

## Deployed Services on Microserver (`evaline-micro-vm`)

1. **Web Server**: Caddy (systemd service `caddy.service`)
2. **Current Domain Mappings**:
   - `evabot.online` -> `/var/www/evabot.online`
   - `www.evabot.online` -> `/var/www/evabot.online`

## Adding New Domains to Same-Named Directories

To connect additional domains (e.g. `domain2.com`) to folders with matching names (`/var/www/domain2.com`):

1. **DNS Setup**: Point the domain's A record to `136.114.26.252`.
2. **Create Web Root**:
   ```bash
   sudo mkdir -p /var/www/domain2.com
   sudo chown -R www-data:www-data /var/www/domain2.com
   ```
3. **Configure Caddy (`/etc/caddy/Caddyfile`)**:
   ```caddy
   domain2.com, www.domain2.com {
       root * /var/www/domain2.com
       file_server
   }
   ```
4. **Reload Web Server**:
   ```bash
   sudo systemctl reload caddy
   ```

