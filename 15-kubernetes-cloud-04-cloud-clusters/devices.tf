resource "yandex_compute_instance" "nat-instance" {
  name = "nat-instance"
  allow_stopping_for_update = true

  resources {
    cores  = 2 
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = var.image
    }
  }

  network_interface {
    subnet_id = "${yandex_vpc_subnet.lab-subnet-a.id}" 
    nat       = true
    ip_address = "192.168.10.254"
  }

  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
  }
}
