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

resource "digitalocean_ssh_key" "tf_ssh_key" {
  name       = "aula-terraform"
  public_key = file("~/.ssh/aula-terraform.pub")
}

# resource "digitalocean_droplet" "vm-aula" {
#   image    = "debian-12-x64"
#   name     = "${var.droplet_name}-${count.index + 1}"
#   region   = var.droplet_region
#   size     = var.droplet_size
#   count    = var.vms_count
#   ssh_keys = [digitalocean_ssh_key.tf_ssh_key.fingerprint]
# }

# output "droplet_id" {
#   value = digitalocean_droplet.vm-aula[*].ipv4_address
# }
