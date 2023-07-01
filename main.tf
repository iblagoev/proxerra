# resource "proxmox_vm_qemu" "nessus" {
#   name        = "nessus"
#   target_node = var.tnode
#   clone       = var.template_name
#   full_clone  = true
#   agent       = 1
#   qemu_os     = "l26"
#   ciuser      = "nessus"
#   sshkeys     = var.sshkey
#   os_type     = "cloud-init"
#   bios        = "ovmf"
#   cores       = 2
#   sockets     = 1
#   cpu         = "kvm64"
#   memory      = 2048
#   balloon     = 0
#   scsihw      = "virtio-scsi-single"

#   network {
#     model  = "virtio"
#     bridge = "vmbr0"
#     tag    = "999"
#   }
# }

resource "proxmox_vm_qemu" "radarr" {
  name        = "radarr"
  target_node = var.tnode00
  clone       = var.template_name_00
  full_clone  = true
  agent       = 1
  qemu_os     = "l26"
  ciuser      = "radarr_adm"
  sshkeys     = var.sshkey
  os_type     = "cloud-init"
  bios        = "ovmf"
  cores       = 1
  sockets     = 1
  cpu         = "kvm64"
  memory      = 1024
  balloon     = 0
  scsihw      = "virtio-scsi-single"

  network {
    model  = "virtio"
    bridge = "vmbr0"
    tag    = "50"
  }
}

resource "proxmox_vm_qemu" "sonarr" {
  name        = "sonarr"
  target_node = var.tnode00
  clone       = var.template_name_00
  full_clone  = true
  agent       = 1
  qemu_os     = "l26"
  ciuser      = "sonarr_adm"
  sshkeys     = var.sshkey
  os_type     = "cloud-init"
  bios        = "ovmf"
  cores       = 1
  sockets     = 1
  cpu         = "kvm64"
  memory      = 1024
  balloon     = 0
  scsihw      = "virtio-scsi-single"

  network {
    model  = "virtio"
    bridge = "vmbr0"
    tag    = "50"
  }
}
resource "proxmox_vm_qemu" "bazarr" {
  name        = "bazarr"
  target_node = var.tnode00
  clone       = var.template_name_00
  full_clone  = true
  agent       = 1
  qemu_os     = "l26"
  ciuser      = "bazarr_adm"
  sshkeys     = var.sshkey
  os_type     = "cloud-init"
  bios        = "ovmf"
  cores       = 1
  sockets     = 1
  cpu         = "kvm64"
  memory      = 1024
  balloon     = 0
  scsihw      = "virtio-scsi-single"

  network {
    model  = "virtio"
    bridge = "vmbr0"
    tag    = "50"
  }
}

resource "proxmox_vm_qemu" "jellyseerr" {
  name        = "jellyseerr"
  target_node = var.tnode00
  clone       = var.template_name_00
  full_clone  = true
  agent       = 1
  qemu_os     = "l26"
  ciuser      = "jellyseerr_adm"
  sshkeys     = var.sshkey
  os_type     = "cloud-init"
  bios        = "ovmf"
  cores       = 1
  sockets     = 1
  cpu         = "kvm64"
  memory      = 1024
  balloon     = 0
  scsihw      = "virtio-scsi-single"

  network {
    model  = "virtio"
    bridge = "vmbr0"
    tag    = "50"
  }
}
resource "proxmox_vm_qemu" "mongodb" {
  name        = "mongo"
  target_node = var.tnode01
  clone       = var.template_name_00
  full_clone  = true
  agent       = 1
  qemu_os     = "l26"
  ciuser      = "mongo_adm"
  sshkeys     = var.sshkey
  os_type     = "cloud-init"
  bios        = "ovmf"
  cores       = 1
  sockets     = 2
  cpu         = "host"
  memory      = 8192
  balloon     = 0
  scsihw      = "virtio-scsi-single"

  network {
    model  = "virtio"
    bridge = "vmbr0"
    tag    = "50"
  }
}

resource "proxmox_vm_qemu" "graylog" {
  name        = "graylog"
  target_node = var.tnode01
  clone       = var.template_name_00
  full_clone  = true
  agent       = 1
  qemu_os     = "l26"
  ciuser      = "glog_adm"
  sshkeys     = var.sshkey
  os_type     = "cloud-init"
  bios        = "ovmf"
  cores       = 2
  sockets     = 2
  cpu         = "kvm64"
  memory      = 8192
  balloon     = 0
  scsihw      = "virtio-scsi-single"

  network {
    model  = "virtio"
    bridge = "vmbr0"
    tag    = "50"
  }
}

