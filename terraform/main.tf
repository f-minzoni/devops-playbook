resource "openstack_compute_instance_v2" "example" {
  name            = "example-${count.index}"
  image_name      = "GNU/Linux Ubuntu Server 16.04 Xenial Xerus x64"
  flavor_name     = "e3standard.x1"
  count           = "1"
  region          = "${var.region}"
  network {
    name = "default"
  }
}

variable "region" {
  default = "nl-ams1"
}

output "private_ip" {
  value = "${openstack_compute_instance_v2.example.access_ip_v4}"
}

resource "openstack_networking_floatingip_v2" "fip_example" {
  pool = "PublicNetwork"
}

resource "openstack_compute_floatingip_associate_v2" "fip_example" {
  floating_ip = "${openstack_networking_floatingip_v2.fip_example.address}"
  instance_id = "${openstack_compute_instance_v2.example.id}"
}