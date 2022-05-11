# NGINX Image Builder

PoC for an NGINX image builder framework

## Mission Statement

Machine gold images provide new revenue streams (for our commercial offerings) as well as improve our community presence (for our OSS offerings). As of today, each PG within the NGINX BU has its own process for creating machine gold images (some PGs don't even have a process to create images). As the NGINX BU keeps growing and new products are developed, creating a unified image builder framework will enable the release team of each PG to easily plug their product build into a cloud image and publish it in the respective marketplace. This framework aims to provide a simple PoC on how such a goal could be accomplished. Furthermore, this framework will allow teams to socialize how images are built and ensure there's no single point of failure in maintaining and publishing these images.

## Framework Overview

Fundamentally, there are two key components in this framework:

1. Packer -> The no. 1 tool (perhaps the only tool?) to create machine gold images. It is very well supported and documented and relatively easy to work with. This PoC uses Packer to spin up a machine gold image on the required cloud environments.
2. Ansible/Bash -> Either Ansible or Bash can be used to provision the machine gold images created by Packer. This PoC includes an example using each option, but the recommended tool is Ansible due to its perfect fit for configuration management use cases (and due to our preexisting Ansible roles).

Additionaly, a simple GitLab CI/CD pipeline has been created to showcase how to potentially automate the image creation whenever a new release is published (or at a regular cron schedule if so desired).

## PoC Overview

As of today, this PoC includes support for two cloud distributions, `Digital Ocean` and `Google Cloud Platform`, and creates machine gold images for `NGINX Open Source`.

## Getting Started

If you want to run this PoC locally, you will have to do a couple things beforehand:

1. Install Packer
2. Install Ansible (optional - alternatively you can tweak the Packer script to only use Bash). If you are running the Packer script locally, you might additionaly need to include `use_proxy = false` as a paremeter in the Ansible block.
