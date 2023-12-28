resource "local_file" "file" {
  content  = var.counted[count.index]
  filename = ".env.${var.counted[count.index]}"
  count    = length(var.counted)
  # file_permission = 0444
  # directory_permission = 444
}

# resource "random_pet" "pet_name" {

# }

variable "counted" {
  default = [ "prod", "staging", "dev", "qa", "qa2" ]
  type = list(string)
}
