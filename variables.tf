variable "gce_ssh_user" {
  type = string
  default = "devops.edc"
}

variable "gce_ssh_pub_key_file" {
  type = string
  default = "/Users/work/.ssh/devops.edc.pub"
}

variable "name" {
  description = "Name prefix for the nodes"
  default = "devops-instance-lesson"
}

variable "num_nodes" {
  description = "Number of nodes to create"
  default = 2
}

variable "project" {
  description = "Project name"
  default = "original-folio-302815"
}

variable "region" {
  description = "Region"
  default = "europe-north1"
}

variable "zone" {
  description = "Zone"
  default = "europe-north1-a"
}

variable "machine_type" {
  description = "Type of instance"
  default = "custom-2-2048"
}

variable "min_cpu_platform" {
  description = "Specifying a minimum CPU platform for VM instances"
  default = "Automatic"
}

variable "image" {
  description = "Specifying type of boot image"
  default = "ubuntu-2004-lts"
}

variable "disk_size" {
  description = "Specifying disk size"
  default = 10
}