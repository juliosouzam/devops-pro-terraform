terraform {
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

resource "digitalocean_kubernetes_cluster" "k8s" {
  name    = "${var.k8s_name}-${terraform.workspace}"
  region  = var.region
  version = var.k8s_version

  node_pool {
    name       = "default"
    size       = var.k8s_node_size
    node_count = var.k8s_node_count
  }

  lifecycle {
    prevent_destroy = false
  }
}

variable "region" {
  type    = string
  default = "nyc1"
}

variable "k8s_name" {
  type    = string
  default = "k8s"
}

variable "k8s_version" {
  type    = string
  default = "1.28.2-do.0"
}

variable "k8s_node_size" {
  type    = string
  default = "s-1vcpu-2gb"
}

variable "k8s_node_count" {
  type    = number
  default = 3
}
