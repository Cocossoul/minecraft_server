terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "3.0.1"
    }
  }
}

provider "docker" {
  host     = "ssh://coco@${minecraft_server_ip}:22"
  ssh_opts = ["-o", "StrictHostKeyChecking=no", "-o", "UserKnownHostsFile=/dev/null"]
}

resource "docker_image" "minecraft_server" {
  name = "minecraft_server:latest"
}

resource "docker_container" "minecraft_server" {
  image = docker_image.minecraft_server.image_id
  name  = "minecraft_server"
  ports = {
    external = 25565
    internal = 25565
  }
  restart = "unless-stopped"
}
