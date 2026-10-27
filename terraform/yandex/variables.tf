variable "cloud_id" {
  type        = string
  description = "ID облака Yandex Cloud"
}

variable "folder_id" {
  type        = string
  description = "ID каталога для ресурсов"
}

variable "default_zone" {
  type        = string
  description = "Зона доступности подсетей и ВМ"
  default     = "ru-central1-a"
}

variable "service_account_key_file" {
  type        = string
  description = "Путь к JSON-ключу сервисного аккаунта"
  default     = "~/.authorized_key.json"
}

variable "project_name" {
  type        = string
  description = "Префикс имён ресурсов"
  default     = "netology-net"
}

variable "public_subnet_cidr" {
  type        = string
  description = "CIDR публичной подсети"
  default     = "192.168.10.0/24"
}

variable "private_subnet_cidr" {
  type        = string
  description = "CIDR приватной подсети"
  default     = "192.168.20.0/24"
}

variable "nat_internal_ip" {
  type        = string
  description = "Внутренний адрес NAT-инстанса, на него смотрит default-маршрут private"
  default     = "192.168.10.254"
}

variable "vm_image_family" {
  type        = string
  description = "Семейство образа тестовых ВМ"
  default     = "ubuntu-2204-lts"
}

variable "nat_image_id" {
  type        = string
  description = "NAT-образ: ip_forward и MASQUERADE уже настроены"
  default     = "fd80mrhj8fl2oe87o4e1"
}

variable "vm_user" {
  type        = string
  description = "Пользователь на ВМ"
  default     = "ubuntu"
}

variable "ssh_public_key" {
  type        = string
  description = "Публичный SSH-ключ для всех ВМ"
}

# Общие параметры трёх машин.
variable "vm_platform_id" {
  type        = string
  description = "Платформа ВМ"
  default     = "standard-v3"
}

variable "vm_cores" {
  type        = number
  description = "vCPU на ВМ"
  default     = 2
}

variable "vm_memory" {
  type        = number
  description = "RAM на ВМ, ГБ"
  default     = 2
}

variable "vm_core_fraction" {
  type        = number
  description = "Гарантированная доля vCPU, %"
  default     = 20
}

variable "vm_disk_size" {
  type        = number
  description = "Размер загрузочного диска, ГБ"
  default     = 10
}
