variable "data" {
  type      = string
  sensitive = true
  ephemeral = true
}

module "test" {
  source = "./modul"
  data   = {
    abc = var.data
    def = 123
  }
}

locals {
  test = {
    foo    = "bar"
    script = module.test.script
  }
}
output "test" {
  value = jsonencode(local.test)
}
