#!/usr/bin/env bash
# Удаление ресурсов
set -euo pipefail

cd "$(dirname "${BASH_SOURCE[0]}")/terraform/yandex"

read -r -p "Удалить ресурсы в Yandex Cloud? [y/N] " answer
if [[ ! "$answer" =~ ^[Yy]$ ]]; then
    echo "Отменено."
    exit 0
fi

terraform destroy -input=false -auto-approve
