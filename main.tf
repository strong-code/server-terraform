terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

# The following are set in terraform.tfvars

variable "do_token" {
  description = "DigitalOcean API token"
  type        = string
  sensitive   = true
}

variable "ssh_key_ids" {
  description = "List of public SSH key IDs to attach to the droplet (~/.ssh/authorized_keys)"
  type        = list(string)
  default     = []
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

resource "digitalocean_firewall" "chl-firewall" {
  name = "chl-firewall"

  droplet_ids = [digitalocean_droplet.chl-server.id]

  inbound_rule {
    protocol         = "tcp"
    port_range       = "22"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  inbound_rule {
    protocol         = "tcp"
    port_range       = "80"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  inbound_rule {
    protocol         = "tcp"
    port_range       = "443"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  # Rizon IRC
  inbound_rule {
    protocol         = "tcp"
    port_range       = "6697"
    source_addresses = ["104.196.111.255/32", "104.199.121.36/32", "192.161.191.29/32"]
  }

  # Chia node
  inbound_rule {
    protocol         = "tcp"
    port_range       = "8444"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol              = "icmp"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol              = "tcp"
    port_range            = "all"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol              = "udp"
    port_range            = "all"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }
}

resource "digitalocean_vpc" "chl-vpc" {
  name     = "default-sfo1"
  region   = "sfo1"
  ip_range = "10.134.0.0/16"
}
