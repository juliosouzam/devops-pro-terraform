output "stack_wp_lb_ip" {
  value       = module.wp_stack.wp_lb_ip
  description = "IP Loadbalancer"
}

output "stack_wp_vm_ips" {
  value       = module.wp_stack.wp_vm_ips
  description = "IPs das máquinas WP"
}

output "stack_wp_nfs_ips" {
  value       = module.wp_stack.wp_nfs_ips
  description = "IPs das máquinas WP NFS"
}

output "stack_wp_db_user" {
  value       = module.wp_stack.wp_db_user
  description = "Usuário do banco de dados"
}

output "stack_wp_db_password" {
  value       = module.wp_stack.wp_db_password
  description = "Senha do banco de dados"
  sensitive   = true
}
