# Create ssh firewall policy
module "server_ssh_sg" {  
  source = "github.com/entercloudsuite/terraform-modules//security?ref=2.4"
  name = "server_ssh_sg"
  region = "${var.region}"
  protocol = "tcp"
  port_range_min = 22
  port_range_max = 22
  allow_remote = "0.0.0.0/0"
}

# Create web firewall policy
module "server_web_sg" {  
  source = "github.com/entercloudsuite/terraform-modules//security?ref=2.4"
  name = "server_web_sg"
  region = "${var.region}"
  protocol = "tcp"
  port_range_min = 80
  port_range_max = 80
  allow_remote = "0.0.0.0/0"
}

# Define cloud init script
data "template_file" "docker-start" {
  template = "${file("bootstrap.sh")}"
}

# Create instance
module "server" {  
  source = "github.com/entercloudsuite/terraform-modules//instance?ref=2.4"
  name = "example-docker"
  image = "packer-docker"
  region = "${var.region}"
  quantity = 1
  external = 1
  flavor = "e3standard.x2"
  network_name = "default"
  allowed_address_pairs = "192.168.0.0/24"
  sec_group = ["${module.server_ssh_sg.sg_id}", "${module.server_web_sg.sg_id}"]
  userdata = "${data.template_file.docker-start.rendered}"
  keypair = "keypair"
}