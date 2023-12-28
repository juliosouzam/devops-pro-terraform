terraform {
  backend "kubernetes" {
    secret_suffix = "tf-state"
    config_path   = "~/.kube/config"
  }

  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

variable "provider_token" {
  type        = string
  description = "Token da Digital Ocean"
}

provider "digitalocean" {
  token = var.provider_token
}


resource "digitalocean_droplet" "web" {
  image  = "ubuntu-20-04-x64"
  name   = "vm-web"
  region = var.region
  size   = "s-1vcpu-1gb"

  # depends_on = [ digitalocean_droplet.jenkins ]

  lifecycle {
    # create_before_destroy = true
    # prevent_destroy = true
    # ignore_changes = [tags]
    # replace_triggered_by = [
    #   digitalocean_droplet.jenkins
    #   # digitalocean_droplet.jenkins.<attribute>
    # ]
    precondition {
      condition     = var.region == "nyc1" || var.region == "nyc3"
      error_message = "Região Inválida"
    }
  }
}

resource "digitalocean_droplet" "jenkins" {
  image  = "ubuntu-20-04-x64"
  name   = "vm-jenkins"
  region = var.region
  size   = "s-1vcpu-1gb"
}

variable "region" {
  default = "nyc1"
}
