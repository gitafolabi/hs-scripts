variable "data" {
  type      = string
  sensitive = true
  ephemeral = true
}

module "test" {
  source = "./modul"
  data   = var.data
}

locals {
  test = {
    foo = "bar"
    script = module.test.script
  }
}
output "test" {
  value = jsonencode(local.test)
}
