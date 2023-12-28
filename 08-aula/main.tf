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

module "wp_stack" {
  source         = "./modules/do-wp-stack"
  provider_token = var.provider_token
  region         = var.region
  vms_count      = var.vms_count
  ssh_key        = digitalocean_ssh_key.ssh_key.fingerprint
}

resource "digitalocean_ssh_key" "ssh_key" {
  name       = "wp-ssh-key"
  public_key = file("~/.ssh/aula-terraform.pub")
}
