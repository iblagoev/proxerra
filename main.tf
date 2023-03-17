terraform {
  required_providers {
    proxmox = {
      source  = "Telmate/proxmox"
      version = "2.9.11"
    }
  }
}

provider "proxmox" {
  pm_api_url          = var.nodeurl
  pm_api_token_id     = var.tokenid
  pm_api_token_secret = var.sekrit
  pm_tls_insecure     = true
}

resource "proxmox_vm_qemu" "Debian" {
  name        = var.vmname
  target_node = var.tnode
  clone       = var.template_name
  full_clone  = true
  agent       = 1
  qemu_os     = "l26"
  ciuser      = var.vmuser
  sshkeys     = var.sshkey
  os_type     = "cloud-init"
  bios        = "ovmf"
  cores       = 1
  sockets     = 1
  cpu         = "kvm64"
  memory      = 1024
  balloon     = 0

  network {
    model  = "virtio"
    bridge = "vmbr0"
    tag    = var.vlanid
  }
}
