provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "sample_bucket12629" {
  count  = "${var.enabled}"
  bucket = "my-tf-test-bucket12629"
  acl    = "private"

  tags {
    Name        = "My bucket"
    Environment = "Dev"
  }
}

resource "aws_vpc" "myvpc" {
  count                = "${var.enabled}"
  cidr_block           = "10.0.128.0/24"
  instance_tenancy     = "default"
  enable_dns_support   = true
  enable_dns_hostnames = true
  enable_classiclink   = false

  tags {
    Name = "aws_vpc"
  }
}

data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_subnet" "app1" {
  count                   = "${var.enabled}"
  vpc_id                  = "${aws_vpc.myvpc.id}"
  cidr_block              = "${cidrsubnet("10.0.128.0/24",2,0)}"
  availability_zone       = "${data.aws_availability_zones.available.names[0]}"
  map_public_ip_on_launch = false
}