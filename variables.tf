variable "gce_ssh_user" {
  type = string
  default = "devops.edc"
}

variable "gce_ssh_pub_key_file" {
  type = string
  default = "/Users/work/.ssh/devops.edc.pub"
}

variable "maven_instance_name" {
  description = "Name prefix for the nodes"
  default = "devops-lesson14-maven-instance"
}

variable "tomcat_instance_name" {
  description = "Name prefix for the nodes"
  default = "devops-lesson14-tomcat-instance"
}

variable "num_nodes" {
  description = "Number of nodes to create"
  default = 1
}

variable "project" {
  description = "Project name"
  default = "original-folio-302815"
}

variable "region" {
  description = "Region"
  default = "europe-west1"
}

variable "zone" {
  description = "Zone"
  default = "europe-west1-b"
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

variable "bucket_name" {
  description = "Specifying bucket name"
  default = "lesson14-app-storage"
}