variable "data" {
  type = string
  sensitive = true
  ephemeral = true
}

module "test" {
  source = "./modul"
  data = var.data
}
