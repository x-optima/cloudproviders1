# Образ по семейству: подтягивается актуальная сборка Ubuntu 22.04.
data "yandex_compute_image" "ubuntu" {
  family = var.vm_image_family
}

# NAT-инстанс: адрес фиксирован, на него смотрит маршрут приватной подсети.
resource "yandex_compute_instance" "nat" {
  name        = "${var.project_name}-nat"
  hostname    = "nat"
  platform_id = var.vm_platform_id
  zone        = var.default_zone

  resources {
    cores         = var.vm_cores
    memory        = var.vm_memory
    core_fraction = var.vm_core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = var.nat_image_id
      size     = var.nat_disk_size
      type     = "network-hdd"
    }
  }

  network_interface {
    subnet_id          = yandex_vpc_subnet.public.id
    ip_address         = var.nat_internal_ip
    nat                = true
    security_group_ids = [yandex_vpc_security_group.vm.id]
  }

  metadata = {
    ssh-keys = "${var.vm_user}:${var.ssh_public_key}"
  }
}

# Точка входа в VPC и jump-хост для приватной подсети.
resource "yandex_compute_instance" "public" {
  name        = "${var.project_name}-public"
  hostname    = "public"
  platform_id = var.vm_platform_id
  zone        = var.default_zone

  resources {
    cores         = var.vm_cores
    memory        = var.vm_memory
    core_fraction = var.vm_core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.id
      size     = var.vm_disk_size
      type     = "network-hdd"
    }
  }

  network_interface {
    subnet_id          = yandex_vpc_subnet.public.id
    nat                = true
    security_group_ids = [yandex_vpc_security_group.vm.id]
  }

  metadata = {
    ssh-keys = "${var.vm_user}:${var.ssh_public_key}"
  }
}

# Без публичного адреса: выход в интернет только через NAT-инстанс.
resource "yandex_compute_instance" "private" {
  name        = "${var.project_name}-private"
  hostname    = "private"
  platform_id = var.vm_platform_id
  zone        = var.default_zone

  resources {
    cores         = var.vm_cores
    memory        = var.vm_memory
    core_fraction = var.vm_core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.id
      size     = var.vm_disk_size
      type     = "network-hdd"
    }
  }

  network_interface {
    subnet_id          = yandex_vpc_subnet.private.id
    nat                = false
    security_group_ids = [yandex_vpc_security_group.vm.id]
  }

  metadata = {
    ssh-keys = "${var.vm_user}:${var.ssh_public_key}"
  }
}
