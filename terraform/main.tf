
provider "google" {
  project     = var.project
  region      = var.region
  zone        = var.zone
  credentials = file(var.credentials_file)
}

resource "google_compute_instance" "vm" {
  name         = "infra-demo-vm"
  machine_type = "e2-micro"
  zone         = var.zone

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
      size  = 10
    }
  }

  network_interface {
    network = "default"
    access_config {} 
  }

  metadata = {
    ssh-keys = "ansible:${file("/Users/juanborron/.ssh/gcp_vm_key.pub")}"
  }
}

output "instance_ip" {
  value = google_compute_instance.vm.network_interface[0].access_config[0].nat_ip
  description = "IP publique de la VM"
}

