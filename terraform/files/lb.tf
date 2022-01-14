data "yandex_compute_image" "my_image" {
  family = "ubuntu-1604-lts"
}

resource "yandex_compute_instance" "lb" {
  name = "load-balancer"
  resources {
    cores  = 2
    memory = 2
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.my_image.id
    }
  }
  network_interface {
    subnet_id = var.subnet_id
    nat       = true
  }
  metadata = {
    ssh-keys = "ubuntu:${file(var.public_key_path)}"
  }
  provisioner "file" {
    source      = "files/nginx.conf"
    destination = "/tmp/nginx.conf"
  }
  provisioner "remote-exec" {
    script = "files/deploy-nginx.sh"
  }
  connection {
    type        = "ssh"
    host        = self.network_interface.0.nat_ip_address
    user        = "ubuntu"
    agent       = false
    private_key = file(var.private_key_path)
  }
}
