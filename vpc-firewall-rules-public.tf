# allow ssh
resource "google_compute_firewall" "public-allow-ssh" {
  name    = "${google_compute_network.public-vpc.name}-allow-ssh"
  network = google_compute_network.public-vpc.name
  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
  source_ranges = [
    "0.0.0.0/0"
  ]
  target_tags = ["allow-ssh"] 
}

# allow ping only from everywhere
resource "google_compute_firewall" "public-allow-ping" {
  name    = "${google_compute_network.public-vpc.name}-allow-ping"
  network = google_compute_network.public-vpc.name
  allow {
    protocol = "icmp"
  }
  source_ranges = [
    "0.0.0.0/0"
  ]
}

# Allow internal traffic on all ports
resource "google_compute_firewall" "public-allow-internal" {
  name    = "${google_compute_network.public-vpc.name}-allow-internal"
  network = google_compute_network.public-vpc.name
  allow {
    protocol = "icmp"
  }
  allow {
    protocol = "tcp"
    ports    = ["0-65535"]
  }
  allow {
    protocol = "udp"
    ports    = ["0-65535"]
  }
  source_ranges = [
    "${var.subnet_cidr_public}"
  ]
}