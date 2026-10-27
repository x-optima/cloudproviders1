# Пустая VPC, внутри две подсети в одной зоне
resource "yandex_vpc_network" "main" {
  name = "${var.project_name}-net"
}

# Публичная подсеть: здесь NAT-инстанс и ВМ с внешним адресом.
resource "yandex_vpc_subnet" "public" {
  name           = "public"
  zone           = var.default_zone
  network_id     = yandex_vpc_network.main.id
  v4_cidr_blocks = [var.public_subnet_cidr]
}

# Default-маршрут приватной подсети ведёт на внутренний адрес NAT-инстанса.
resource "yandex_vpc_route_table" "private" {
  name       = "${var.project_name}-private-rt"
  network_id = yandex_vpc_network.main.id

  static_route {
    destination_prefix = "0.0.0.0/0"
    next_hop_address   = var.nat_internal_ip
  }
}

# Приватная подсеть: наружу только через NAT-инстанс.
resource "yandex_vpc_subnet" "private" {
  name           = "private"
  zone           = var.default_zone
  network_id     = yandex_vpc_network.main.id
  v4_cidr_blocks = [var.private_subnet_cidr]
  route_table_id = yandex_vpc_route_table.private.id
}
