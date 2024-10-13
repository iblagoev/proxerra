terraform {
  required_providers {
    proxmox = {
      source  = "Telmate/proxmox"
      version = "3.0.1-rc4"
    }
  }
}

provider "proxmox" {
  pm_api_url          = var.nodeurl
  pm_api_token_id     = var.tokenid
  pm_api_token_secret = var.sekrit
  pm_tls_insecure     = true
}
