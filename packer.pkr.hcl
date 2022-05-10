packer {
  required_plugins {
    digitalocean = {
      version = ">= 1.0.0"
      source  = "github.com/hashicorp/digitalocean"
    }
    googlecompute = {
      version = ">= 1.0.0"
      source  = "github.com/hashicorp/googlecompute"
    }
  }
}

variable "digitalocean_auth" {
  default = env("DIGITALOCEAN_TOKEN")
  validation {
    condition     = length(var.digitalocean_auth) > 0
    error_message = <<EOF
The digitalocean_auth var is not set: make sure to set the DIGITALOCEAN_TOKEN env var.
EOF
  }
}

variable "googlecompute_auth" {
  default = env("GOOGLE_APPLICATION_CREDENTIALS")
  validation {
    condition     = length(var.googlecompute_auth) > 0
    error_message = <<EOF
The googlecompute_auth var is not set: make sure to set the GOOGLE_APPLICATION_CREDENTIALS env var.
EOF
  }
}

source "digitalocean" "nginx-oss" {
  api_token     = var.digitalocean_auth
  region        = "sfo3"
  image         = "ubuntu-20-04-x64"
  size          = "s-1vcpu-1gb"
  ssh_username  = "root"
  snapshot_name = "nginx-oss"
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

source "googlecompute" "nginx-oss" {
  account_file        = var.googlecompute_auth
  project_id          = "f5-gcs-5598-mktg-nginx-bizdev"
  zone                = "us-west1-a"
  source_image_family = "ubuntu-2004-lts"
  ssh_username        = "root"
  image_name          = "nginx-oss"
  image_storage_locations = [
    "us",
  ]
}

build {
  name = "Install NGINX Open Source (Ansible)"
  sources = [
    "source.digitalocean.nginx-oss",
  ]
  provisioner "ansible" {
    galaxy_file   = "./requirements.yml"
    playbook_file = "./playbook.yml"
  }
}

build {
  name = "Install NGINX Open Source (Bash)"
  sources = [
    "source.googlecompute.nginx-oss",
  ]
  provisioner "shell" {
    script = "./install-nginx.sh"
  }
}
