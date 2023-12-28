

output "droplet_ip" {
  value       = digitalocean_droplet.vm-aula[*].ipv4_address
  depends_on  = [digitalocean_droplet.vm-aula]
  description = "Droplet IPV4"
}
