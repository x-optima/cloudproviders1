#!/usr/bin/env bash
# Развёртывание стенда
set -euo pipefail

cd "$(dirname "${BASH_SOURCE[0]}")/terraform/yandex"

if [[ ! -f terraform.tfvars ]]; then
    echo "Нет файла terraform/yandex/terraform.tfvars. Создайте его из шаблона:" >&2
    echo "  cp terraform/yandex/terraform.tfvars.example terraform/yandex/terraform.tfvars" >&2
    exit 1
fi

terraform init -input=false
terraform apply -input=false -auto-approve
terraform output
