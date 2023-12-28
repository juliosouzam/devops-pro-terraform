resource "local_file" "file01" {
  content  = "${var.value_string} ${count.index}"
  filename = "./file${count.index}.txt"
  count    = 4
}

resource "local_file" "file02" {
  content  = "${var.value_string} ${each.value}"
  filename = "./file-${each.key}.txt"
  for_each = var.each
}

variable "each" {
  default = ["vm1", "vm2", "vm3"]
  type    = set(string)
}

variable "value_string" {
  default     = "Conteudo default do arquivo"
  type        = string
  description = "Conteudo que vai para o arquivo"
}
