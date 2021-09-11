terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

# Set in .tfvars
variable "do_token" {
  description = "DigitalOcean API token"
  type        = string
  sensitive   = true
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
}
