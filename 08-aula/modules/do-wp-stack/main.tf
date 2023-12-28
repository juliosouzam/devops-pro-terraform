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

resource "digitalocean_vpc" "wp_net" {
  name   = "wp-network"
  region = var.region
}

resource "digitalocean_loadbalancer" "wp_lb" {
  name   = "wp-lb"
  region = var.region

  forwarding_rule {
    entry_port     = 80
    entry_protocol = "http"

    target_port     = 80
    target_protocol = "http"
  }

  healthcheck {
    port     = 80
    protocol = "http"
    path     = "/"
  }

  vpc_uuid    = digitalocean_vpc.wp_net.id
  droplet_ids = digitalocean_droplet.vm_wp[*].id
}


resource "digitalocean_droplet" "vm_wp" {
  name     = "${var.droplet_name}-${count.index + 1}"
  image    = "debian-12-x64"
  region   = var.region
  size     = var.droplet_size
  ssh_keys = [var.ssh_key]
  count    = var.droplet_count
  vpc_uuid = digitalocean_vpc.wp_net.id
}

resource "digitalocean_droplet" "vm_nfs" {
  name     = "${var.droplet_name}-nfs-${count.index + 1}"
  image    = "debian-12-x64"
  region   = var.region
  size     = var.droplet_size
  ssh_keys = [var.ssh_key]
  count    = var.vms_count
  vpc_uuid = digitalocean_vpc.wp_net.id
}

resource "digitalocean_database_db" "wp_database" {
  cluster_id = digitalocean_database_cluster.wp_mysql.id
  name       = "wp-database"
}

resource "digitalocean_database_cluster" "wp_mysql" {
  name                 = "wp-mysql"
  engine               = "mysql"
  version              = "8"
  size                 = "db-s-1vcpu-1gb"
  region               = var.region
  node_count           = 1
  private_network_uuid = digitalocean_vpc.wp_net.id
}

resource "digitalocean_database_user" "wp_database_user" {
  cluster_id = digitalocean_database_cluster.wp_mysql.id
  name       = "wordpress"
}
