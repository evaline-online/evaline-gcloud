# Evaline Google Cloud Project Setup

This repository contains management scripts, documentation, and configuration for the **Evaline** Google Cloud Platform environment (`evabot.online@gmail.com`).

## Overview

- **Account**: `evabot.online@gmail.com`
- **Project ID**: `evabot-agent-server`
- **Primary Region / Zone**: `europe-west3` / `europe-west3-b`
- **Primary Server**: `evaline-server-001`

## Usage

```bash
./setup-gcloud.sh install    # Install gcloud CLI only
./setup-gcloud.sh connect    # Authorize & connect via SSH
```

## Environment Variables

| Variable | Default | Description |
|---|---|---|
| `VM_NAME` | `evaline-server-001` | Compute Engine VM instance name |
| `ZONE` | `europe-west3-b` | GCP Compute Engine Zone |
| `SSH_USER` | `fedor` | SSH Username |
| `PROJECT` | `evabot-agent-server` | GCP Project ID |

## Trilingual Documentation

- [English Documentation](file:///home/fedor/Desktop/evaline-gcloud/README.en.md)
- [Русская документация](file:///home/fedor/Desktop/evaline-gcloud/README.ru.md)
- [Українська документація](file:///home/fedor/Desktop/evaline-gcloud/README.uk.md)
