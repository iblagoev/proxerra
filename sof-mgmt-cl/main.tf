terraform {
  backend "local" {
    path = "terraform.tfstate"
  }
}
resource "proxmox_vm_qemu" "boinc-research" {
  name        = "boinc-research"
  tags        = "opensuse"
  onboot      = true
  target_node = var.node-loki
  full_clone  = false
  agent       = 1
  qemu_os     = "l26"
  ciuser      = "svc-ops"
  sshkeys     = var.sshkey
  os_type     = "cloud-init"
  bios        = "ovmf"
  cores       = 2
  sockets     = 1
  cpu         = "x86-64-v2-AES"
  memory      = 2048
  balloon     = 0
  scsihw      = "pvscsi"
  vm_state    = "running"
  ipconfig0   = "ip=dhcp"
  smbios {
    uuid = var.uuid_boinc
  }
  network {
    model   = "vmxnet3"
    bridge  = "vmbr0"
    macaddr = var.mac_boinc
    tag     = var.services_network
  }
  disks {
    scsi {
      scsi0 {
        disk {
          backup     = true
          discard    = false
          emulatessd = false
          format     = "raw"
          iothread   = false
          replicate  = true
          size       = "24G"
          storage    = "local-lvm"
        }
      }
    }
    ide {
      ide2 {
        cloudinit {
          storage = "local-lvm"
        }
      }
    }
  }
}
resource "proxmox_vm_qemu" "github_runner" {
  name                   = "gh-runner"
  onboot                 = false
  target_node            = var.node-thor
  define_connection_info = false
  full_clone             = false
  agent                  = 1
  qemu_os                = "l26"
  ciuser                 = "svc-ops"
  ciupgrade              = true
  sshkeys                = var.sshkey
  os_type                = "cloud-init"
  bios                   = "ovmf"
  cores                  = 1
  sockets                = 1
  cpu                    = "host"
  memory                 = 1024
  balloon                = 0
  scsihw                 = "virtio-scsi-pci"
  ipconfig0              = "ip=dhcp"
  vm_state               = "stopped"
  smbios {
    uuid = var.uuid_ghruuner
  }
  network {
    model   = "virtio"
    bridge  = "vmbr0"
    tag     = var.services_network
    macaddr = var.mac_ghrunner
  }
  disks {
    scsi {
      scsi0 {
        disk {
          discard    = true
          emulatessd = true
          size       = "8G"
          storage    = "local-lvm"
        }
      }
    }
    ide {
      ide2 {
        cloudinit {
          storage = "local-lvm"
        }
      }
    }
  }
}
resource "proxmox_vm_qemu" "app" {
  name        = "react-app"
  onboot      = false
  target_node = var.node-loki
  full_clone  = false
  agent       = 1
  qemu_os     = "l26"
  ciuser      = "svc-ops"
  ciupgrade   = true
  sshkeys     = var.sshkey
  os_type     = "cloud-init"
  bios        = "ovmf"
  cores       = 1
  sockets     = 1
  cpu         = "host"
  memory      = 2048
  balloon     = 0
  scsihw      = "virtio-scsi-pci"
  ipconfig0   = "ip=dhcp"
  vm_state    = "running"
  smbios {
    uuid = var.uuid_react
  }
  network {
    model   = "virtio"
    bridge  = "vmbr0"
    tag     = var.services_network
    macaddr = var.mac_react
  }

  disks {
    scsi {
      scsi0 {
        disk {
          discard    = true
          emulatessd = true
          size       = "15G"
          storage    = "local-lvm"
        }
      }
    }
    ide {
      ide2 {
        cloudinit {
          storage = "local-lvm"
        }
      }
    }
  }
}
resource "proxmox_vm_qemu" "jenkins" {
  name        = "jenkins"
  vmid        = 118
  onboot      = false
  target_node = var.node-loki
  clone       = var.debian12-template
  full_clone  = true
  agent       = 1
  qemu_os     = "l26"
  ciuser      = "svc-ops"
  ciupgrade   = true
  sshkeys     = var.sshkey
  os_type     = "cloud-init"
  bios        = "ovmf"
  cores       = 1
  sockets     = 1
  cpu         = "host"
  memory      = 4096
  balloon     = 0
  scsihw      = "virtio-scsi-pci"
  ipconfig0   = "ip=dhcp"
  vm_state    = "stopped"

  network {
    model  = "virtio"
    bridge = "vmbr0"
    tag    = var.services_network
  }

  disks {
    scsi {
      scsi0 {
        disk {
          discard    = true
          emulatessd = true
          size       = "15G"
          storage    = "sof-datalake"
        }
      }
    }
    ide {
      ide2 {
        cloudinit {
          storage = "sof-datalake"
        }
      }
    }
  }
}
resource "proxmox_vm_qemu" "checkmk" {
  name        = "checkmk"
  tags        = "debian"
  onboot      = false
  target_node = var.node-odin
  full_clone  = false
  agent       = 1
  qemu_os     = "l26"
  ciuser      = "svc-ops"
  sshkeys     = var.sshkey
  bios        = "ovmf"
  cores       = 2
  sockets     = 1
  cpu         = "x86-64-v2-AES"
  memory      = 6144
  balloon     = 6144
  scsihw      = "pvscsi"
  os_type     = "cloud-init"
  ipconfig0   = "ip=dhcp"
  vm_state    = "running"

  smbios {
    uuid = var.uuid_checkmk
  }
  network {
    model   = "vmxnet3"
    bridge  = "vmbr0"
    macaddr = var.mac_checkmk
    tag     = var.monitor_network
  }
  disks {
    scsi {
      scsi0 {
        disk {
          format    = "qcow2"
          size      = "60G"
          replicate = true
          storage   = "sof-datalake"
        }
      }
    }
    ide {
      ide2 {
        cloudinit {
          storage = "sof-datalake"
        }
      }
    }
  }
}
resource "proxmox_vm_qemu" "terraform" {
  name        = "terraform"
  tags        = "debian"
  onboot      = false
  target_node = var.node-thor
  full_clone  = false
  agent       = 1
  qemu_os     = "l26"
  ciuser      = "svc-ops"
  sshkeys     = var.sshkey
  bios        = "ovmf"
  cores       = 2
  sockets     = 1
  cpu         = "x86-64-v2-AES"
  memory      = 1024
  balloon     = 1024
  scsihw      = "virtio-scsi-pci"
  os_type     = "cloud-init"
  ipconfig0   = "ip=dhcp"
  vm_state    = "stopped"

  smbios {
    uuid = var.uuid_terraform
  }
  network {
    model   = "virtio"
    bridge  = "vmbr0"
    macaddr = var.mac_terraform
    tag     = var.mgmt_network
  }
  disks {
    scsi {
      scsi0 {
        disk {
          format     = "raw"
          size       = "8G"
          storage    = "local-lvm"
          discard    = true
          emulatessd = true
          replicate  = true
        }
      }
    }
    ide {
      ide2 {
        cloudinit {
          storage = "local-lvm"
        }
      }
    }
  }
}
resource "proxmox_vm_qemu" "teamcity" {
  name        = "teamcity"
  tags        = "debian"
  onboot      = false
  target_node = var.node-thor
  full_clone  = false
  agent       = 1
  qemu_os     = "l26"
  ciuser      = "svc-ops"
  sshkeys     = var.sshkey
  bios        = "ovmf"
  cores       = 2
  sockets     = 1
  cpu         = "x86-64-v2-AES"
  memory      = 6144
  balloon     = 6144
  scsihw      = "pvscsi"
  os_type     = "cloud-init"
  ipconfig0   = "ip=dhcp"
  vm_state    = "running"

  smbios {
    uuid = var.uuid_teamcity
  }
  network {
    model   = "vmxnet3"
    bridge  = "vmbr0"
    macaddr = var.mac_teamcity
    tag     = var.services_network
  }
  disks {
    scsi {
      scsi0 {
        disk {
          format    = "vmdk"
          size      = "35G"
          replicate = true
          storage   = "sof-datalake"
        }
      }
    }
    ide {
      ide2 {
        cloudinit {
          storage = "sof-datalake"
        }
      }
    }
  }
}
resource "proxmox_vm_qemu" "youtrack" {
  name        = "youtrack"
  tags        = "debian"
  onboot      = false
  target_node = var.node-thor
  full_clone  = false
  agent       = 1
  qemu_os     = "l26"
  ciuser      = "svc-ops"
  sshkeys     = var.sshkey
  bios        = "ovmf"
  cores       = 2
  sockets     = 1
  cpu         = "x86-64-v2-AES"
  memory      = 6144
  balloon     = 6144
  scsihw      = "pvscsi"
  os_type     = "cloud-init"
  ipconfig0   = "ip=dhcp"
  vm_state    = "stopped"

  smbios {
    uuid = var.uuid_youtrack
  }
  network {
    model   = "vmxnet3"
    bridge  = "vmbr0"
    macaddr = var.mac_youtrack
    tag     = var.services_network
  }
  disks {
    scsi {
      scsi0 {
        disk {
          format    = "vmdk"
          size      = "16G"
          replicate = true
          storage   = "sof-datalake"
        }
      }
    }
    ide {
      ide2 {
        cloudinit {
          storage = "sof-datalake"
        }
      }
    }
  }
}
resource "proxmox_vm_qemu" "dockyard" {
  name        = "dockyard"
  tags        = "opensuse"
  onboot      = true
  target_node = var.node-odin
  full_clone  = false
  agent       = 1
  qemu_os     = "l26"
  ciuser      = "svc-ops"
  sshkeys     = var.sshkey
  bios        = "ovmf"
  cores       = 4
  sockets     = 1
  cpu         = "x86-64-v2-AES"
  memory      = 16384
  balloon     = 16384
  scsihw      = "pvscsi"
  os_type     = "cloud-init"
  ipconfig0   = "ip=dhcp"
  vm_state    = "running"

  smbios {
    uuid = var.uuid_dockyard
  }
  network {
    model   = "vmxnet3"
    bridge  = "vmbr0"
    macaddr = var.mac_dockyard
    tag     = var.services_network
  }
  disks {
    scsi {
      scsi0 {
        disk {
          format    = "qcow2"
          size      = "80G"
          replicate = true
          storage   = "sof-datalake"
        }
      }
    }
    ide {
      ide2 {
        cloudinit {
          storage = "sof-datalake"
        }
      }
    }
  }
}
resource "proxmox_vm_qemu" "harbor" {
  name        = "harbor"
  tags        = "debian"
  onboot      = true
  target_node = var.node-thor
  full_clone  = false
  agent       = 1
  qemu_os     = "l26"
  ciuser      = "svc-ops"
  sshkeys     = var.sshkey
  bios        = "ovmf"
  cores       = 2
  sockets     = 1
  cpu         = "x86-64-v2-AES"
  memory      = 8192
  balloon     = 8192
  scsihw      = "pvscsi"
  os_type     = "cloud-init"
  ipconfig0   = "ip=dhcp"
  vm_state    = "running"

  smbios {
    uuid = var.uuid_harbor
  }
  network {
    model   = "vmxnet3"
    bridge  = "vmbr0"
    macaddr = var.mac_harbor
    tag     = var.services_network
  }
  disks {
    scsi {
      scsi0 {
        disk {
          format    = "qcow2"
          size      = "50G"
          replicate = true
          storage   = "sof-datalake"
        }
      }
    }
    ide {
      ide2 {
        cloudinit {
          storage = "sof-datalake"
        }
      }
    }
  }
}
resource "proxmox_vm_qemu" "graylog" {
  name        = "graylog"
  tags        = "debian"
  onboot      = true
  target_node = var.node-odin
  full_clone  = false
  agent       = 1
  qemu_os     = "l26"
  ciuser      = "svc-ops"
  sshkeys     = var.sshkey
  bios        = "ovmf"
  cores       = 3
  sockets     = 1
  cpu         = "x86-64-v2-AES"
  memory      = 10240
  balloon     = 10240
  scsihw      = "pvscsi"
  os_type     = "cloud-init"
  ipconfig0   = "ip=dhcp"
  vm_state    = "running"

  smbios {
    uuid = var.uuid_graylog
  }
  network {
    model   = "vmxnet3"
    bridge  = "vmbr0"
    macaddr = var.mac_graylog
    tag     = var.servers_network
  }
  disks {
    scsi {
      scsi0 {
        disk {
          format    = "qcow2"
          size      = "90G"
          replicate = true
          storage   = "sof-datalake"
        }
      }
    }
    ide {
      ide2 {
        cloudinit {
          storage = "sof-datalake"
        }
      }
    }
  }
}
resource "proxmox_vm_qemu" "mongo" {
  name        = "mongo"
  tags        = "debian"
  startup     = "order=3,up=1,down=100"
  onboot      = true
  target_node = var.node-thor
  full_clone  = false
  agent       = 1
  qemu_os     = "l26"
  ciuser      = "svc-ops"
  sshkeys     = var.sshkey
  bios        = "ovmf"
  cores       = 2
  sockets     = 1
  cpu         = "host"
  memory      = 6144
  balloon     = 6144
  scsihw      = "pvscsi"
  os_type     = "cloud-init"
  ipconfig0   = "ip=dhcp"
  vm_state    = "running"

  smbios {
    uuid = var.uuid_mongo
  }
  network {
    model   = "vmxnet3"
    bridge  = "vmbr0"
    macaddr = var.mac_mongo
    tag     = var.services_network
  }
  disks {
    scsi {
      scsi0 {
        disk {
          format    = "raw"
          size      = "20G"
          replicate = true
          storage   = "data-sata-dell"
        }
      }
    }
    ide {
      ide2 {
        cloudinit {
          storage = "data-sata-dell"
        }
      }
    }
  }
}
resource "proxmox_vm_qemu" "sdns" {
  name        = "sdns"
  tags        = "debian"
  startup     = "order=2,up=1,down=100"
  onboot      = true
  target_node = var.node-odin
  full_clone  = false
  agent       = 1
  qemu_os     = "l26"
  bios        = "ovmf"
  ciuser      = "svc-ops"
  sshkeys     = var.sshkey
  cores       = 1
  sockets     = 1
  cpu         = "x86-64-v2-AES"
  memory      = 1024
  balloon     = 0
  scsihw      = "pvscsi"
  os_type     = "cloud-init"
  ipconfig0   = "ip=dhcp"
  vm_state    = "running"

  smbios {
    uuid = var.uuid_sdns
  }
  network {
    model   = "vmxnet3"
    bridge  = "vmbr0"
    macaddr = var.mac_sdns
    tag     = var.mgmt_network
  }
  disks {
    scsi {
      scsi0 {
        disk {
          format    = "raw"
          size      = "12G"
          replicate = true
          storage   = "local-lvm"
        }
      }
    }
    ide {
      ide2 {
        cloudinit {
          storage = "local-lvm"
        }
      }
    }
  }
}
resource "proxmox_vm_qemu" "pdns" {
  name        = "pdns"
  tags        = "debian"
  startup     = "order=1,up=1,down=100"
  onboot      = true
  target_node = var.node-thor
  full_clone  = false
  agent       = 1
  qemu_os     = "l26"
  bios        = "ovmf"
  ciuser      = "svc-ops"
  sshkeys     = var.sshkey
  cores       = 1
  sockets     = 1
  cpu         = "x86-64-v2-AES"
  memory      = 1024
  balloon     = 0
  scsihw      = "pvscsi"
  os_type     = "cloud-init"
  ipconfig0   = "ip=dhcp"
  vm_state    = "running"

  smbios {
    uuid = var.uuid_pdns
  }
  network {
    model   = "vmxnet3"
    bridge  = "vmbr0"
    macaddr = var.mac_pdns
    tag     = var.mgmt_network
  }
  disks {
    scsi {
      scsi0 {
        disk {
          format    = "raw"
          size      = "15G"
          replicate = true
          storage   = "data-sata-dell"
        }
      }
    }
    ide {
      ide2 {
        cloudinit {
          storage = "data-sata-dell"
        }
      }
    }
  }
}
