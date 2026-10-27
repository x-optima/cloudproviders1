# SSH и ICMP снаружи, любой трафик внутри VPC, исходящий без ограничений.
resource "yandex_vpc_security_group" "vm" {
  name       = "${var.project_name}-vm-sg"
  network_id = yandex_vpc_network.main.id

  ingress {
    description    = "SSH"
    protocol       = "TCP"
    port           = 22
    v4_cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description    = "ICMP"
    protocol       = "ICMP"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description    = "Трафик внутри VPC"
    protocol       = "ANY"
    v4_cidr_blocks = [var.public_subnet_cidr, var.private_subnet_cidr]
  }

  egress {
    description    = "Исходящий трафик"
    protocol       = "ANY"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
}
