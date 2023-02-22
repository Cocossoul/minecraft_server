terraform {
  required_providers {
    vultr = {
      source = "vultr/vultr"
      version = "2.12.0"
    }
  }
}

# Configure the Vultr Provider
provider "vultr" {
  rate_limit = 100
  retry_limit = 3
}

resource "vultr_instance" "minecraft_server" {
    plan = "vc2-1c-2gb"
    region = "cdg"
    os_id = 1743
    label = "minecraft-server"
    hostname = "minecraft-server"
    enable_ipv6 = false
    activation_email = true
    ssh_key_ids = [ "60f8f596-14d5-4d06-a662-51ce92f4adf3" ]
    script_id = vultr_startup_script.startup_script.id
}

resource "vultr_startup_script" "startup_script" {
    name = "minecraft-server-startup-script"
    type = "boot"
    script = filebase64("startup_script.sh")
}

resource "local_file" "ansible_inventory" {
  content = templatefile("inventory.yml.tmpl",
    {
        minecraft_server_ip = vultr_instance.minecraft_server.main_ip
    }
  )
  filename = "inventory.yml"
}

output "minecraft_server_ip" {
    value = vultr_instance.minecraft_server.main_ip
}
