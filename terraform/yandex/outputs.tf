output "public_vm_external_ip" {
  description = "Публичный IP ВМ в подсети public"
  value       = yandex_compute_instance.public.network_interface[0].nat_ip_address
}

output "public_vm_internal_ip" {
  description = "Внутренний IP ВМ в подсети public"
  value       = yandex_compute_instance.public.network_interface[0].ip_address
}

output "private_vm_internal_ip" {
  description = "Внутренний IP ВМ в подсети private"
  value       = yandex_compute_instance.private.network_interface[0].ip_address
}

output "nat_external_ip" {
  description = "Публичный IP NAT-инстанса"
  value       = yandex_compute_instance.nat.network_interface[0].nat_ip_address
}

output "ssh_public_vm" {
  description = "Подключение к публичной ВМ"
  value       = "ssh ${var.vm_user}@${yandex_compute_instance.public.network_interface[0].nat_ip_address}"
}

output "ssh_private_vm" {
  description = "Подключение к приватной ВМ через публичную"
  value = join("", [
    "ssh -J ${var.vm_user}@${yandex_compute_instance.public.network_interface[0].nat_ip_address} ",
    "${var.vm_user}@${yandex_compute_instance.private.network_interface[0].ip_address}"
  ])
}
