#HW1 without nat and private network
resource "yandex_vpc_network" "hw_network" {
  name        = var.vpc_name
  description = "VPC for the cloud providers homework"
  labels      = var.labels
}

resource "yandex_vpc_subnet" "public" {
  name           = var.public_subnet_name
  description    = "Public subnet with NAT instance and bastion VM"
  zone           = var.default_zone
  network_id     = yandex_vpc_network.hw_network.id
  v4_cidr_blocks = [var.public_subnet_cidr]
  labels         = var.labels
}
