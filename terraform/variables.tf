#HW 15.1 without unused params 

variable "sa_key_file" {
  type        = string
  description = "Path to the Yandex Cloud service account key file"
}

variable "cloud_id" {
  type        = string
  description = "Yandex Cloud ID"
}

variable "folder_id" {
  type        = string
  description = "Yandex Cloud folder ID"
}

variable "default_zone" {
  type        = string
  description = "Default Yandex Cloud availability zone"
  default     = "ru-central1-a"
}

variable "vpc_name" {
  type        = string
  description = "Name of the VPC network"
  default     = "netology-vpc"
}

variable "public_subnet_name" {
  type        = string
  description = "Name of the public subnet"
  default     = "public"
}

variable "public_subnet_cidr" {
  type        = string
  description = "CIDR block for the public subnet"
  default     = "192.168.10.0/24"
}

variable "vm_platform_id" {
  type        = string
  description = "Yandex Compute Cloud platform ID"
  default     = "standard-v3"
}

variable "vm_cores" {
  type        = number
  description = "Number of vCPUs for each VM"
  default     = 2
}

variable "vm_memory" {
  type        = number
  description = "Memory size for each VM, GB"
  default     = 2
}

variable "vm_core_fraction" {
  type        = number
  description = "Baseline CPU performance percentage"
  default     = 20
}

variable "vm_disk_size" {
  type        = number
  description = "Boot disk size for each VM, GB"
  default     = 10
}

variable "vm_preemptible" {
  type        = bool
  description = "Create preemptible VMs"
  default     = true
}

variable "vm_disk_type" {
  type        = string
  description = "Boot disk type for Ubuntu VMs"
  default     = "network-hdd"
}

variable "vm_user" {
  type        = string
  description = "Username created by cloud-init"
  default     = "ubuntu"
}

variable "public_key_path" {
  type        = string
  description = "Path to the SSH public key file"
}

variable "labels" {
  type        = map(string)
  description = "Labels applied to created resources"
  default = {
    project = "netology"
    hw      = "clopro-15-2"
  }
}

#Object storage

variable "bucket_name" {
  type        = string
  description = "Globally unique Object Storage bucket name"
}

variable "image_object_key" {
  type        = string
  description = "Object key for the uploaded image"
  default     = "images/image.jpg"
}

variable "image_source_path" {
  type        = string
  description = "Local path to the image file"
  default     = "/files/image.jpg"
}

variable "image_content_type" {
  type        = string
  description = "Content type of the uploaded image"
  default     = "image/jpeg"
}

# LAMP Instance Group

variable "lamp_image_id" {
  type        = string
  description = "LAMP image ID for the instance group template"
  default     = "fd827b91d99psvq5fjit"
}

# ID сервисного аккаунта для Instance Group.
variable "service_account_id" {
  type        = string
  description = "ID of the service account used by the instance group"
}

# Количество VM в Instance Group.
variable "instance_group_size" {
  type        = number
  description = "Fixed number of VMs in the instance group"
  default     = 3
}