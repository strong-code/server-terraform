terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

provider "digitalocean" {
  token = var.do_token
}

resource "digitalocean_droplet" "chl-server" {
  image      = "72067660"
  name       = "chl-server"
  region     = "sfo1"
  size       = "s-1vcpu-1gb"
  monitoring = true
  ipv6       = true
  ssh_keys   = var.ssh_key_ids
}

resource "digitalocean_vpc" "chl-vpc" {
  name     = "default-sfo1"
  region   = "sfo1"
  ip_range = "10.134.0.0/16"
}

