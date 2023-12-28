module "pets-01" {
  source     = "./modules/pets"
  prefix     = "pets-01"
  depends_on = [module.pets-02]
}

module "pets-02" {
  source = "./modules/pets"
  prefix = "pets-0${each.key}" // count.index + 1
  # count = 10
  for_each = toset(["01", "02", "03", "04"])
}

