# output "dhcp_ip_nessus" {
#   value = proxmox_vm_qemu.nessus.default_ipv4_address
# }

# output "username_nessus" {
#   value = proxmox_vm_qemu.nessus.ciuser
# }

output "ip_radarr" {
  value = proxmox_vm_qemu.radarr.default_ipv4_address
}

output "username_radarr" {
  value = proxmox_vm_qemu.radarr.ciuser
}

output "ip_sonarr" {
  value = proxmox_vm_qemu.sonarr.default_ipv4_address
}

output "username_sonarr" {
  value = proxmox_vm_qemu.sonarr.ciuser
}

output "ip_bazarr" {
  value = proxmox_vm_qemu.bazarr.default_ipv4_address
}

output "username_bazarr" {
  value = proxmox_vm_qemu.bazarr.ciuser
}

output "ip_jellyseerr" {
  value = proxmox_vm_qemu.jellyseerr.default_ipv4_address
}

output "username_jellyseerr" {
  value = proxmox_vm_qemu.jellyseerr.ciuser
}
