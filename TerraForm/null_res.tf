variable "vpc_ids" {
  default = [
    "vpc1",
    "vpc2",
    "vpc3",
  ]
}

resource "null_resource" "tion" {
  count = length(compact(var.vpc_ids))

  triggers {
    vpcs = join(",", var.vpc_ids)
  }

  provisioner "local-exec" {
    when    = create
    command = "echo create ${var.vpc_ids[count.index]}"
  }

  provisioner "local-exec" {
    when    = destroy
    command = "echo destroy"
  }
}

resource "null_resource" "sh_test" {
  provisioner "local-exec" {
    when        = create
    command     = "if [ '${join(",", var.vpc_ids)}' != '' ]; then echo 'GOOD TO GO'; else echo 'NO VPC FOUND'; fi"
    interpreter = ["/bin/sh", "-c"]
  }
}
