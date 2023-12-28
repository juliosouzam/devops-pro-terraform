terraform {
  #   backend "local" {
  #     path = "./terraform.tfstate"
  #   }

  #   backend "pg" {
  #     conn_str = "<postgres url>"
  #   }

  backend "kubernetes" {
    secret_suffix = "tf-state"
    config_path   = "~/.kube/config"
  }
}

resource "local_file" "file" {
  content  = var.envs[count.index]
  filename = ".env.${var.envs[count.index]}"
  count    = length(var.envs)
}

variable "envs" {
  default = ["prod", "staging", "dev", "qa"]
  type    = list(string)
}
