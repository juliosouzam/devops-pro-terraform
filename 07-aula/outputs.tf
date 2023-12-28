output "name_p1" {
  value = module.pets-01
}

output "name_p2" {
  value = module.pets-02[*]
}