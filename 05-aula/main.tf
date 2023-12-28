resource "local_file" "max" {
  content  = max(54, 19, 20, 68)
  filename = "max.txt"
}

resource "local_file" "min" {
  content  = min(54, 19, 20, 68)
  filename = "min.txt"
}

resource "local_file" "starts_with" {
  content  = startswith("Hi, boss, how are u?", "Hi")
  filename = "startswith.txt"
}

resource "local_file" "ends_with" {
  content  = endswith("Hi, boss, how are u?", "u")
  filename = "endswith.txt"
}

resource "local_file" "join" {
  content  = join(", ", ["devops", "terraform", "docker", "k8s", "aws", "cloud"])
  filename = "join.txt"
}

resource "local_file" "upper" {
  #   content  = upper("devops, terraform, docker, k8s, aws, cloud")
  content  = upper(join(", ", ["devops", "terraform", "docker", "k8s", "aws", "cloud"]))
  filename = "upper.txt"
}

resource "local_file" "lower" {
  #   content  = lower("devops, terraform, docker, k8s, aws, cloud")
  content  = lower(join(", ", ["deVops", "terraForm", "dOcker", "K8s", "aws", "cLoud"]))
  filename = "lower.txt"
}

resource "local_file" "trimspace" {
  content  = trimspace(join(", ", ["     deVops", "terraForm", "dOcker", "K8s", "aws", "cLoud   "]))
  filename = "trimspace.txt"
}

resource "local_file" "file" {
  content  = file("~/.ssh/aula-terraform.pub")
  filename = "file.txt"
}

resource "local_file" "expressions" {
  content  = 50 * 10 - 5 / 2 # 10 == 5 -> false; 10 > 2 ? "Maior" : "Menor"
  filename = "expressions.txt"
}

resource "local_file" "loops" {
  content  = join(", ", [for v in ["vm1   ", "   vm2", "   vm3     "] : upper(trimspace(v))])
  filename = "loops.txt"
}

variable "list" {
  default = ["devops", "terraform", "docker", "k8s", "aws", "cloud"]
  validation {
    condition     = contains(var.list, "k8s")
    error_message = "Valor não encontrado"
  }
}
