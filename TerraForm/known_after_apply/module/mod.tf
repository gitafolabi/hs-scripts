variable "input_run" {
  type = bool
}

resource "random_string" "key" {
  count   = var.input_run ? 1 : 0
  length  = 32
  special = false
}

locals {
  platform = {
    x = {
      abc = var.input_run ? base64encode(random_string.key[0].result) : "",
      def = try(random_string.key[0].result, "def")
    }
  }
}

output "platform" {
  value = local.platform
}
