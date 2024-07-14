resource "proxmox_vm_qemu" "k8s_control" {
  count = 2

  name                   = "k8s-control-${count.index}"
  vmid                   = 500 + count.index
  target_node            = "proxmox"
  machine                = "q35"
  cpu                    = "x86-64-v2-AES"
  cores                  = 2
  memory                 = 4096
  scsihw                 = "virtio-scsi-single"
  os_type                = "l26"
  bios                   = "ovmf"
  boot                   = "order=scsi0;ide2"
  agent                  = 1
  onboot                 = true
  full_clone             = false
  define_connection_info = false
  automatic_reboot       = false

  disks {
    scsi {
      scsi0 {
        disk {
          storage   = "local-lvm"
          size      = "64G"
          iothread  = true
          replicate = true
        }
      }
    }

    ide {
      ide2 {
        cdrom {
          passthrough = false
        }
      }
    }
  }

  network {
    model    = "virtio"
    bridge   = "vmbr0"
    firewall = true
  }
}

resource "proxmox_vm_qemu" "k8s_worker" {
  count = 2

  name                   = "k8s-worker-${count.index}"
  vmid                   = 550 + count.index
  target_node            = "proxmox"
  machine                = "q35"
  cpu                    = "x86-64-v2-AES"
  cores                  = 8
  memory                 = 16384
  scsihw                 = "virtio-scsi-single"
  os_type                = "l26"
  bios                   = "ovmf"
  boot                   = "order=scsi0;ide2"
  agent                  = 1
  onboot                 = true
  full_clone             = false
  define_connection_info = false
  automatic_reboot       = false

  disks {
    scsi {
      scsi0 {
        disk {
          storage   = "local-lvm"
          size      = "256G"
          iothread  = true
          replicate = true
        }
      }
    }

    ide {
      ide2 {
        cdrom {
          passthrough = false
        }
      }
    }
  }

  network {
    model    = "virtio"
    bridge   = "vmbr0"
    firewall = true
  }
}
