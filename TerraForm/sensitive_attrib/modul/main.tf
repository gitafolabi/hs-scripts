variable "data" {
  sensitive = true
  ephemeral = true
}

locals {
  foo = {
    "data" : var.data
    "foo" : "bar"
  }
}

resource "terraform_data" "test" {
  triggers_replace = timestamp()
  provisioner "local-exec" {
    when    = create
    command = "echo ${var.data}"
  }
}

resource "terraform_data" "external_file" {
  triggers_replace = timestamp()
  provisioner "local-exec" {
    when        = create
    interpreter = ["/bin/bash", "-c"]
    command     = file("${path.module}/hello.sh")
  }
}

output "script" {
  value = file("${path.module}/hello.sh")
}
