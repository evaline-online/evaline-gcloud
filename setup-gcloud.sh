#!/usr/bin/env bash
# setup-gcloud.sh — Google Cloud CLI Setup & SSH Connection for Evaline Project
# Account: evabot.online@gmail.com
# Project: evabot-agent-server

set -euo pipefail

# Parameters & Environment Defaults
VM_NAME="${VM_NAME:-evaline-server-001}"
ZONE="${ZONE:-europe-west3-b}"
SSH_USER="${SSH_USER:-fedor}"
PROJECT="${PROJECT:-evabot-agent-server}"
NET_TIMEOUT="${NET_TIMEOUT:-20}"

echo "=========================================================="
echo " Evaline GCP Setup & Connection Script"
echo " Target Project : ${PROJECT}"
echo " Target Instance: ${VM_NAME} (${ZONE})"
echo " Target User    : ${SSH_USER}"
echo "=========================================================="

install_gcloud() {
    if command -v gcloud &>/dev/null; then
        echo "[INFO] gcloud CLI is already installed."
        gcloud --version | head -n 1
        return 0
    fi

    echo "[INFO] Installing gcloud CLI..."
    if command -v apt-get &>/dev/null; then
        sudo apt-get update -y
        sudo apt-get install -y apt-transport-https ca-certificates gnupg curl
        curl -fsSL https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo gpg --dearmor -o /usr/share/keyrings/cloud.google.gpg --yes
        echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee /etc/apt/sources.list.d/google-cloud-sdk.list
        sudo apt-get update -y && sudo apt-get install -y google-cloud-cli
    elif command -v dnf &>/dev/null; then
        sudo dnf install -y google-cloud-cli
    else
        echo "[ERROR] Unsupported package manager. Please install google-cloud-cli manually."
        exit 1
    fi
}

auth_and_connect() {
    echo "[INFO] Setting active project to: ${PROJECT}"
    gcloud config set project "${PROJECT}" || true
    gcloud config set compute/zone "${ZONE}" || true

    ACTIVE_ACCOUNT=$(gcloud config get-value account 2>/dev/null || echo "")
    if [ -z "${ACTIVE_ACCOUNT}" ] || [ "${ACTIVE_ACCOUNT}" = "(unset)" ]; then
        echo "[INFO] No active account logged in. Launching authorization..."
        gcloud auth login
    else
        echo "[INFO] Active GCP account: ${ACTIVE_ACCOUNT}"
    fi

    echo "[INFO] Connecting via SSH to ${VM_NAME}..."
    gcloud compute ssh "${SSH_USER}@${VM_NAME}" --zone="${ZONE}" -- -o ConnectTimeout="${NET_TIMEOUT}"
}

case "${1:-connect}" in
    install)
        install_gcloud
        ;;
    connect)
        install_gcloud
        auth_and_connect
        ;;
    *)
        echo "Usage: $0 {install|connect}"
        exit 1
        ;;
esac
