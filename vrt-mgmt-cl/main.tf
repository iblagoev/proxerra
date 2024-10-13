terraform {
  backend "local" {
    path = "terraform.tfstate"
  }
}
resource "proxmox_vm_qemu" "suse-leap" {
  name        = "prometheus"
  vmid        = 201
  tags        = "suse"
  onboot      = true
  target_node = var.tnode00
  clone       = var.template_name_00
  full_clone  = true
  agent       = 1
  qemu_os     = "l26"
  ciuser      = "svc-ops"
  sshkeys     = var.sshkey
  os_type     = "cloud-init"
  bios        = "ovmf"
  cores       = 1
  sockets     = 1
  cpu         = "host"
  memory      = 4096
  balloon     = 0
  scsihw      = "virtio-scsi-pci"

  network {
    model   = "virtio"
    bridge  = "vmbr0"
    macaddr = var.mac_suse
  }
}
resource "proxmox_vm_qemu" "boinc-research" {
  name        = "boinc-research"
  vmid        = 202
  tags        = "suse"
  onboot      = true
  target_node = var.tnode00
  clone       = var.template_name_00
  full_clone  = true
  agent       = 1
  qemu_os     = "l26"
  ciuser      = "svc-ops"
  sshkeys     = var.sshkey
  os_type     = "cloud-init"
  bios        = "ovmf"
  cores       = 2
  sockets     = 1
  cpu         = "host"
  memory      = 4096
  balloon     = 4096
  scsihw      = "virtio-scsi-pci"

  network {
    model  = "virtio"
    bridge = "vmbr0"
  }
}
