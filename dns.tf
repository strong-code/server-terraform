resource "digitalocean_domain" "strongcode" {
  name       = "strongco.de"
  ip_address = digitalocean_droplet.chl-server.ipv4_address
}

resource "digitalocean_record" "www" {
  domain = digitalocean_domain.strongcode.name
  type   = "A"
  name   = "wwww"
  value  = digitalocean_droplet.chl-server.ipv4_address
}

resource "digitalocean_record" "botto" {
  domain = digitalocean_domain.strongcode.name
  type   = "A"
  name   = "botto"
  value  = digitalocean_droplet.chl-server.ipv4_address
}

resource "digitalocean_record" "health" {
  domain = digitalocean_domain.strongcode.name
  type   = "A"
  name   = "health"
  value  = digitalocean_droplet.chl-server.ipv4_address
}

resource "digitalocean_record" "start" {
  domain = digitalocean_domain.strongcode.name
  type   = "A"
  name   = "start"
  value  = digitalocean_droplet.chl-server.ipv4_address
}

resource "digitalocean_record" "mx10" {
  domain   = digitalocean_domain.strongcode.name
  type     = "MX"
  priority = "10"
  name     = "@"
  value    = "mx.zoho.com."
}

resource "digitalocean_record" "mx20" {
  domain   = digitalocean_domain.strongcode.name
  type     = "MX"
  priority = "20"
  name     = "@"
  value    = "mx2.zoho.com."
}

resource "digitalocean_record" "mail_verification" {
  domain = digitalocean_domain.strongcode.name
  type   = "TXT"
  name   = "@"
  value  = var.mail_verification_record
}
