
variable "droplet_name" {
  default     = "vm-aula"
  type        = string
  description = "Nome dos Droplets"
}

variable "droplet_region" {
  default     = "nyc1"
  type        = string
  description = "Região dos Droplets"
}

variable "droplet_size" {
  default     = "s-1vcpu-512mb-10gb"
  type        = string
  description = "Tamanho dos Droplets"
}

variable "vms_count" {
  default     = 1
  type        = number
  description = "Quantidade de Droplets"
}

variable "provider_token" {
  #   default = ""
  type        = string
  description = "Token do Digital Ocean"
}
