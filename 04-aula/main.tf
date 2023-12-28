terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "2.34.0"
    }
  }
}

provider "digitalocean" {
  token = var.provider_token
}

resource "digitalocean_droplet" "vm-aula-local-exec" {
  image    = "debian-12-x64"
  name     = "${var.droplet_name}-le-${count.index + 1}"
  region   = var.droplet_region
  size     = var.droplet_size
  ssh_keys = [data.digitalocean_ssh_key.ssh_key.id]
  count    = var.vms_count

  provisioner "local-exec" {
    command = "echo VM com IP: ${self.ipv4_address} criada"
  }
}

resource "digitalocean_droplet" "vm-aula-remote-exec" {
  image    = "debian-12-x64"
  name     = "${var.droplet_name}-re-${count.index + 1}"
  region   = var.droplet_region
  size     = var.droplet_size
  ssh_keys = [data.digitalocean_ssh_key.ssh_key.id]
  count    = var.vms_count

  connection {
    type        = "ssh"
    host        = self.ipv4_address
    user        = "root"
    private_key = file("~/.ssh/aula-terraform")
  }

  provisioner "remote-exec" {
    inline = ["apt update", "apt install curl -y", "apt install nginx -y", "curl -fsSL https://get.docker.com | sh"]
  }
}

resource "digitalocean_droplet" "vm-aula-file-exec" {
  image    = "debian-12-x64"
  name     = "${var.droplet_name}-re-${count.index + 1}"
  region   = var.droplet_region
  size     = var.droplet_size
  ssh_keys = [data.digitalocean_ssh_key.ssh_key.id]
  count    = var.vms_count

  connection {
    type        = "ssh"
    host        = self.ipv4_address
    user        = "root"
    private_key = file("~/.ssh/aula-terraform")
  }

  provisioner "file" {
    source = "install.sh"
    destination = "/root/install.sh"
  }

  provisioner "remote-exec" {
    inline = [ "chmod +x /root/install.sh", "sh /root/install.sh" ]
  }
}
