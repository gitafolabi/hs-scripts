variable "data" {
  sensitive = true
  ephemeral = true
}

locals {
  foo = {
    "data": var.data
    "foo": "bar"
  }
}

resource "terraform_data" "test" {
  triggers_replace = timestamp()
  provisioner "local-exec" {
    when = create
    command = "echo ${var.data}"
  }
}