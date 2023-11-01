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
  onboot      = true
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
  balloon     = 1024
  scsihw      = "virtio-scsi-single"

  network {
    model   = "virtio"
    bridge  = "vmbr0"
    tag     = "80"
    macaddr = "8e:07:50:a0:34:0e"
  }
}

resource "proxmox_vm_qemu" "sonarr" {
  name        = "sonarr"
  onboot      = true
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
  balloon     = 1024
  scsihw      = "virtio-scsi-single"

  network {
    model   = "virtio"
    bridge  = "vmbr0"
    tag     = "80"
    macaddr = "2e:bb:4c:f7:29:52"
  }
}

resource "proxmox_vm_qemu" "jellyseerr" {
  name        = "jellyseerr"
  onboot      = false
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
  balloon     = 1024
  scsihw      = "virtio-scsi-single"

  network {
    model   = "virtio"
    bridge  = "vmbr0"
    tag     = "80"
    macaddr = "8a:c8:f7:91:b7:3e"
  }
}

resource "proxmox_vm_qemu" "graylog" {
  onboot      = true
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
  cpu         = "x86-64-v2"
  memory      = 10240
  balloon     = 7168
  scsihw      = "virtio-scsi-single"

  network {
    model  = "virtio"
    bridge = "vmbr0"
    tag    = "50"
  }
}

resource "proxmox_vm_qemu" "prowlarr" {
  onboot      = true
  name        = "prowlarr"
  target_node = var.tnode00
  clone       = var.template_name_00
  full_clone  = true
  agent       = 1
  qemu_os     = "l26"
  ciuser      = "prow_adm"
  sshkeys     = var.sshkey
  os_type     = "cloud-init"
  bios        = "ovmf"
  cores       = 1
  sockets     = 1
  cpu         = "kvm64"
  memory      = 1024
  balloon     = 1024
  scsihw      = "virtio-scsi-single"

  network {
    model   = "virtio"
    bridge  = "vmbr0"
    tag     = "80"
    macaddr = "32:e3:dd:5f:f0:99"
  }
}

resource "proxmox_vm_qemu" "rbg" {
  name        = "rbg"
  onboot      = true
  target_node = var.tnode00
  clone       = var.template_name_00
  full_clone  = true
  agent       = 1
  qemu_os     = "l26"
  ciuser      = "rbg_adm"
  sshkeys     = var.sshkey
  os_type     = "cloud-init"
  bios        = "ovmf"
  cores       = 1
  sockets     = 1
  cpu         = "kvm64"
  memory      = 512
  balloon     = 512
  scsihw      = "virtio-scsi-single"

  network {
    model  = "virtio"
    bridge = "vmbr0"
    tag    = "80"
  }
}

resource "proxmox_vm_qemu" "unifi-controller" {
  name        = "ucontroller"
  tags        = "mgmt"
  onboot      = true
  target_node = var.tnode01
  clone       = var.template_name_01
  full_clone  = true
  agent       = 1
  qemu_os     = "l26"
  ciuser      = "unifi_adm"
  sshkeys     = var.sshkey
  os_type     = "cloud-init"
  bios        = "ovmf"
  cores       = 2
  sockets     = 1
  cpu         = "kvm64"
  memory      = 2048
  balloon     = 1024
  scsihw      = "virtio-scsi-single"

  network {
    model   = "virtio"
    bridge  = "vmbr0"
    tag     = "90"
    macaddr = var.mac_unifi
  }
}
resource "proxmox_vm_qemu" "blackhole" {
  name        = "blackhole"
  vmid        = 101
  tags        = "dns"
  onboot      = true
  target_node = var.tnode01
  clone       = var.template_name_01
  full_clone  = true
  agent       = 1
  qemu_os     = "l26"
  ciuser      = "dns_adm"
  sshkeys     = var.sshkey
  os_type     = "cloud-init"
  bios        = "ovmf"
  cores       = 2
  sockets     = 1
  cpu         = "kvm64"
  memory      = 1024
  balloon     = 1024
  scsihw      = "virtio-scsi-single"

  network {
    model   = "virtio"
    bridge  = "vmbr0"
    tag     = "90"
    macaddr = var.mac_sdns
  }
}

resource "proxmox_vm_qemu" "pdns" {
  name        = "pihole"
  vmid        = 119
  tags        = "dns"
  onboot      = true
  target_node = var.tnode00
  clone       = var.template_name_00
  full_clone  = true
  agent       = 1
  qemu_os     = "l26"
  ciuser      = "dns_adm"
  sshkeys     = var.sshkey
  os_type     = "cloud-init"
  bios        = "ovmf"
  cores       = 2
  sockets     = 1
  cpu         = "kvm64"
  memory      = 1024
  balloon     = 1024
  scsihw      = "virtio-scsi-single"

  network {
    model   = "virtio"
    bridge  = "vmbr0"
    tag     = "90"
    macaddr = var.mac_pdns
  }
}

resource "proxmox_vm_qemu" "mongodb" {
  onboot      = true
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
  memory      = 4096
  balloon     = 2048
  scsihw      = "virtio-scsi-single"
  tags        = "db"

  network {
    model   = "virtio"
    bridge  = "vmbr0"
    tag     = "80"
    macaddr = var.mongo_dns
  }
}
resource "proxmox_vm_qemu" "mongodb_2" {
  onboot      = true
  name        = "mongo2"
  target_node = var.tnode01
  clone       = var.template_name_01
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
  memory      = 4096
  balloon     = 2048
  scsihw      = "virtio-scsi-single"
  tags        = "db"

  network {
    model   = "virtio"
    bridge  = "vmbr0"
    tag     = "80"
    macaddr = var.mongo2_dns
  }
}
resource "proxmox_vm_qemu" "mongodb_3" {
  onboot      = true
  name        = "mongo3"
  target_node = var.tnode00
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
  memory      = 4096
  balloon     = 2048
  scsihw      = "virtio-scsi-single"
  tags        = "db"

  network {
    model   = "virtio"
    bridge  = "vmbr0"
    tag     = "80"
    macaddr = var.mongo3_dns
  }
}

resource "proxmox_vm_qemu" "checkmk" {
  name        = "checkmk"
  tags        = "monitor"
  onboot      = true
  target_node = var.tnode01
  clone       = var.template_name_01
  full_clone  = true
  agent       = 1
  qemu_os     = "l26"
  ciuser      = "chkmk_adm"
  sshkeys     = var.sshkey
  os_type     = "cloud-init"
  bios        = "ovmf"
  cores       = 1
  sockets     = 1
  cpu         = "kvm64"
  memory      = 4096
  balloon     = 2048
  scsihw      = "virtio-scsi-single"

  network {
    model  = "virtio"
    bridge = "vmbr0"
    tag    = "50"
  }
}

resource "proxmox_vm_qemu" "uptime-kuma" {
  name        = "uptime-kuma"
  tags        = "monitor"
  onboot      = true
  target_node = var.tnode00
  clone       = var.template_name_00
  full_clone  = true
  agent       = 1
  qemu_os     = "l26"
  ciuser      = "kuma_adm"
  sshkeys     = var.sshkey
  os_type     = "cloud-init"
  bios        = "ovmf"
  cores       = 1
  sockets     = 1
  cpu         = "x86-64-v2"
  memory      = 1024
  balloon     = 1024
  scsihw      = "virtio-scsi-single"

  network {
    model   = "virtio"
    bridge  = "vmbr0"
    tag     = "80"
    macaddr = var.uptime
  }
}

resource "proxmox_vm_qemu" "teamcity" {
  name        = "teamcity"
  tags        = "build"
  onboot      = true
  target_node = var.tnode01
  clone       = var.template_name_01
  full_clone  = true
  agent       = 1
  qemu_os     = "l26"
  ciuser      = "tc_adm"
  sshkeys     = var.sshkey
  os_type     = "cloud-init"
  bios        = "ovmf"
  cores       = 2
  sockets     = 2
  cpu         = "x86-64-v2"
  memory      = 4098
  balloon     = 4098
  scsihw      = "virtio-scsi-single"

  network {
    model  = "virtio"
    bridge = "vmbr0"
    tag    = "80"
  }
}

resource "proxmox_vm_qemu" "postgre" {
  name        = "postgre"
  tags        = "sql"
  onboot      = true
  target_node = var.tnode01
  clone       = var.template_name_01
  full_clone  = true
  agent       = 1
  qemu_os     = "l26"
  ciuser      = "sql_adm"
  sshkeys     = var.sshkey
  os_type     = "cloud-init"
  bios        = "ovmf"
  cores       = 2
  sockets     = 1
  cpu         = "x86-64-v2"
  memory      = 2048
  balloon     = 2048
  scsihw      = "virtio-scsi-single"

  network {
    model   = "virtio"
    bridge  = "vmbr0"
    tag     = "80"
    macaddr = var.postgre
  }
}

resource "proxmox_vm_qemu" "docker-tc" {
  name        = "docker-tc"
  tags        = "build"
  onboot      = true
  target_node = var.tnode01
  clone       = var.template_name_01
  full_clone  = true
  agent       = 1
  qemu_os     = "l26"
  ciuser      = "tca_adm"
  sshkeys     = var.sshkey
  os_type     = "cloud-init"
  bios        = "ovmf"
  cores       = 2
  sockets     = 1
  cpu         = "x86-64-v2"
  memory      = 2048
  balloon     = 2048
  scsihw      = "virtio-scsi-single"

  network {
    model   = "virtio"
    bridge  = "vmbr0"
    tag     = "80"
    macaddr = var.docker-tc
  }
}
