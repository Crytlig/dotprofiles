locals {
  iso_url = "https://channels.nixos.org/nixos-${var.version}/latest-nixos-${var.distro}-${var.arch}-linux.iso"
}

variable "builder" {
  description = "builder"
  type = string
}

variable "distro" {
  type = string
  description = "Distribution"
}

variable "version" {
  description = "The version of NixOS to build"
  type = string
}

variable "arch" {
  description = "The system architecture of NixOS to build (Default: x86_64)"
  type = string
  default = "x86_64"
}

variable "iso_checksum" {
  description = "A ISO SHA256 value"
  type = string
}

variable "disk_size" {
  type    = string
  default = "20240"
}

variable "memory" {
  type    = string
  default = "1024"
}

variable "boot_wait" {
  description = "The amount of time to wait for VM boot"
  type = string
  default = "120s"
}

source "virtualbox-iso" "virtualbox" {
  boot_command         = [
    "echo http://{{ .HTTPIP }}:{{ .HTTPPort }} > .packer_http<enter>",
    "mkdir -m 0700 .ssh<enter>",
    "sudo systemctl start display-manager<enter>",
    "curl $(cat .packer_http)/install_ed25519.pub > .ssh/authorized_keys<enter>",
    "sudo systemctl start sshd<enter>"
  ]
  boot_wait            = "45s"
  disk_size            = var.disk_size
  format               = "ova"
  guest_additions_mode = "disable"
  guest_os_type        = "Linux_64"
  headless             = true
  http_directory       = "scripts"
  iso_checksum         = var.iso_checksum
  iso_url              = local.iso_url
  shutdown_command     = "sudo shutdown -h now"
  ssh_port             = 22
  usb                  = true
  ssh_private_key_file = "./scripts/install_ed25519"
  ssh_username         = "nixos"
  vboxmanage           = [["modifyvm", "{{ .Name }}", "--memory", var.memory, "--vram", "128", "--clipboard", "bidirectional", "--mouse", "usbtablet"]]
}


build {
  sources = [
    "source.virtualbox-iso.virtualbox",
  ]

  provisioner "shell" {
    execute_command = "sudo su -c '{{ .Vars }} {{ .Path }}'"
    script          = "./scripts/install.sh"
  }

  post-processor "vagrant" {
    keep_input_artifact = false
    only                = ["virtualbox-iso.virtualbox"]
    output              = "nixos-${var.version}-${var.builder}-${var.arch}.box"
  }
}
