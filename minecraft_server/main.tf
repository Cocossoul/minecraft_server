terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "3.0.1"
    }
  }
}

variable "minecraft_server_ip" {
  type = string
}

provider "docker" {
  host     = "ssh://coco@${var.minecraft_server_ip}:22"
  ssh_opts = ["-o", "StrictHostKeyChecking=no", "-o", "UserKnownHostsFile=/dev/null"]
}

data "docker_registry_image" "minecraft_server" {
  name = "cocopaps/minecraft_server:latest"
}

resource "docker_image" "minecraft_server" {
  name          = data.docker_registry_image.minecraft_server.name
  pull_triggers = [data.docker_registry_image.minecraft_server.sha256_digest]
}

resource "docker_container" "minecraft_server" {
  image = docker_image.minecraft_server.image_id
  name  = "minecraft_server"
  ports {
    external = 25565
    internal = 25565
  }
  restart = "unless-stopped"
}
