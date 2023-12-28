
variable "droplet_name" {
  default     = "wp"
  type        = string
  description = "Nome dos Droplets"
}

variable "region" {
  type        = string
  description = "Região"
}

variable "droplet_size" {
  default     = "s-1vcpu-512mb-10gb"
  type        = string
  description = "Tamanho dos Droplets"
}

variable "droplet_count" {
  default     = 3
  type        = number
  description = "Quantidade de Droplets Wordpress"
  validation {
    condition     = var.droplet_count > 1
    error_message = "Número mínimo de instâncias são 2"
  }
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

variable "ssh_key" {
  type = string
  description = "Chave SSH"
}