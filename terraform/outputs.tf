output "load_balancer_ip" {
  description = "Public IP address of the network load balancer"
  value       = one(one(yandex_lb_network_load_balancer.web.listener).external_address_spec).address
}

output "image_url" {
  description = "Public URL of the uploaded image"
  value       = "https://storage.yandexcloud.net/${var.bucket_name}/${var.image_object_key}"
}

output "bucket_name" {
  description = "Created Object Storage bucket name"
  value       = yandex_storage_bucket.images.bucket
}

output "target_group_id" {
  description = "ID of the load balancer target group"
  value       = yandex_compute_instance_group.web.load_balancer[0].target_group_id
}

output "instance_group_ips" {
  description = "External and internal IP addresses of all Instance Group VMs"

  value = {
    for instance in yandex_compute_instance_group.web.instances :
    instance.name => {
      external = instance.network_interface[0].nat_ip_address
      internal = instance.network_interface[0].ip_address
    }
  }
}