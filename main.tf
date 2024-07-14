terraform {
  required_version = "~> 1.9"

  required_providers {
    proxmox = {
      source  = "Telmate/proxmox"
      version = "3.0.1-rc3"
    }
  }

  cloud {
    organization = "s6n-jp"

    workspaces {
      name = "proxmox"
    }
  }
}

provider "proxmox" {
  pm_api_url = "https://proxmox.s6n.jp:8006/api2/json"
}
