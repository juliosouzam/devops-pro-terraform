output "droplets_le_ip" {
  value       = digitalocean_droplet.vm-aula-local-exec[*].ipv4_address
  depends_on  = [digitalocean_droplet.vm-aula-local-exec]
  description = "LE Droplets IPV4"
}

output "droplets_re_ip" {
  value       = digitalocean_droplet.vm-aula-remote-exec[*].ipv4_address
  depends_on  = [digitalocean_droplet.vm-aula-remote-exec]
  description = "RE Droplets IPV4"
}
