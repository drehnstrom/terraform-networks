# allow ssh only from public subnet
resource "google_compute_firewall" "private-allow-ssh" {
  name    = "${google_compute_network.private-vpc.name}-allow-ssh"
  network = google_compute_network.private-vpc.name
  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
  source_ranges = [
    "${var.subnet_cidr_public}"
  ]
  target_tags = ["allow-ssh"] 
}

# allow ping only from public subnet
resource "google_compute_firewall" "private-allow-ping" {
  name    = "${google_compute_network.private-vpc.name}-allow-ping"
  network = google_compute_network.private-vpc.name
  allow {
    protocol = "icmp"
  }
  source_ranges = [
    "${var.subnet_cidr_public}"
  ]
}

# Allow internal traffic on all ports
resource "google_compute_firewall" "private-allow-internal" {
  name    = "${google_compute_network.private-vpc.name}-allow-internal"
  network = google_compute_network.private-vpc.name
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
    "${var.subnet_cidr_private}"
  ]
}