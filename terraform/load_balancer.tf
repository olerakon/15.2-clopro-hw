# Сетевой балансировщик нагрузки.
resource "yandex_lb_network_load_balancer" "web" {
  name        = "lamp-network-lb"
  description = "Network load balancer for the LAMP instance group"
  labels      = var.labels

  listener {
    name        = "http-listener"
    port        = 80
    target_port = 80
    protocol    = "tcp"

    external_address_spec {
      ip_version = "ipv4"
    }
  }

  attached_target_group {
    target_group_id = yandex_compute_instance_group.web.load_balancer[0].target_group_id

    healthcheck {
      name                = "http-healthcheck"
      interval            = 10
      timeout             = 5
      healthy_threshold   = 2
      unhealthy_threshold = 2

      http_options {
        port = 80
        path = "/"
      }
    }
  }
}