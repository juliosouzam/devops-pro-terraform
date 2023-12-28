resource "local_file" "foo" {
  content  = "O valor é ${var.value_tuple[1]}"
  filename = "./arquivo.txt"
}

variable "value_string" {
  default     = "Conteudo default do arquivo"
  type        = string
  description = "Conteudo que vai para o arquivo"
}

variable "value_number" {
  default     = 1
  type        = number
  description = "Conteudo que vai para o arquivo"
}

variable "value_boolean" {
  default     = true
  type        = bool
  description = "Conteudo que vai para o arquivo"
}

variable "value_list" {
  default     = [1, 2, 3, 4, 5]
  type        = list(number)
  description = "Conteudo que vai para o arquivo"
}

variable "value_map" {
  default = {
    "small"  = "small"
    "medium" = "medium"
    "large"  = "large"
  }
  type        = map(string)
  description = "Conteudo que vai para o arquivo"
}

variable "value_set" {
  default     = ["small", "medium", "large"]
  type        = set(string)
  description = "Conteudo que vai para o arquivo"
}

variable "value_object" {
  default = {
    region = "us-east-1"
    option = "small"
    bkp    = false
  }
  type = object({
    region = string, option = string, bkp = bool
  })
  description = "Conteudo que vai para o arquivo"
}

variable "value_tuple" {
  default     = ["us-east-1", "small", false]
  type        = tuple([string, string, bool])
  description = "Conteudo que vai para o arquivo"
}
