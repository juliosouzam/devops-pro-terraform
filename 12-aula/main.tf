terraform {
  backend "kubernetes" {
    secret_suffix = "tf-state-12-aula"
    config_path   = "~/.kube/config"
  }
}

resource "local_file" "file" {
  content  = var.content
  filename = ".env.${terraform.workspace}"
#   count    = length(var.envs)
}

variable "envs" {
  default = ["prod", "staging", "dev", "qa"]
  type    = list(string)
}

variable "content" {
  type        = string
  description = "Valor do conteúdo"
}

