packer {
  required_plugins {
    digitalocean = {
      version = "= 1.0.4"
      source  = "github.com/hashicorp/digitalocean"
    }
  }
}

source "digitalocean" "nginx" {
  region = "sfo3"
  size = "s-1vcpu-1gb"
  image = "ubuntu-20-04-x64"
  ssh_username = "root"
  snapshot_name = "nginx"
  snapshot_regions = [
    "ams2",
    "ams3",
    "blr1",
    "fra1",
    "lon1",
    "nyc1",
    "nyc2",
    "nyc3",
    "sfo1",
    "sfo2",
    "sfo3",
    "sgp1",
    "tor1",
  ]
}

build {
  name = "Install NGINX Open Source"
  sources = [
    "source.digitalocean.nginx",
  ]
  provisioner "ansible" {
    playbook_file = "./playbook.yml"
  }
}
