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
