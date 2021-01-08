variable "environment" {
  type    = string
}

variable "region" {
  type    = string
}

variable "key_name" {
  type    = string
  default = "laptop-key"
}

variable "public_key" {
  type    = string
}

variable "ami_name" {
  type    = string
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}
variable "ssh_port" {
  type    = string
  default = "22"
}

variable "http_port" {
  type    = string
  default = "80"
}

variable "https_port" {
  type    = string
  default = "443"
}
variable "s3_bucket" {
  values = "${var.s3_bucket}"
}
variable "s3_folder_project" {
  values = "${var.s3_bucket}"
}
variable "s3_folder_region" {
  values = "${var.s3_folder_region}"
}
variable "s3_folder_type" {
  values = "${var.s3_folder_type}"
}
variable "s3_tfstate_file" {
   values = "${var.s3_bucket}"
}
variable "any_port" {
  type    = string
  default = "0"
}

variable "any_protocol" {
  type    = string
  default = "-1"
}

variable "tcp_protocol" {
  type    = string
  default = "tcp"
}

variable "all_ips" {
  type    = list
  default = ["0.0.0.0/0"]
}

data "aws_vpcs" "my-vpc" {
  tags = {
    environment = var.environment
  }
}

data "aws_subnet_ids" "my-subnets" {
  vpc_id = tolist(data.aws_vpcs.my-vpc.ids)[0]
}

data "aws_ami" "packer" {
  most_recent = true
  filter {
    name   = "name"
    values = [var.ami_name]
  }
  owners = ["self"]
}
