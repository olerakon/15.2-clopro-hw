# Instance Group из трёх LAMP VM в public subnet.
resource "yandex_compute_instance_group" "web" {
  name               = "lamp-web-group"
  description        = "Fixed-size LAMP instance group"
  folder_id          = var.folder_id
  service_account_id = var.service_account_id
  labels             = var.labels

  instance_template {
    name        = "lamp-{instance.index}"
    hostname    = "lamp-{instance.index}"
    platform_id = var.vm_platform_id
    labels      = var.labels

    resources {
      cores         = var.vm_cores
      memory        = var.vm_memory
      core_fraction = var.vm_core_fraction
    }

    boot_disk {
      initialize_params {
        image_id = var.lamp_image_id
        type     = var.vm_disk_type
        size     = var.vm_disk_size
      }
    }

    network_interface {
      network_id = yandex_vpc_network.hw_network.id
      subnet_ids = [yandex_vpc_subnet.public.id]
      nat        = true
    }

    metadata = {
      user-data = templatefile("${path.module}/lamp-user-data.yml", {
        bucket_name      = var.bucket_name
        image_object_key = var.image_object_key
      })

      ssh-keys = "${var.vm_user}:${file(var.public_key_path)}"
    }

    scheduling_policy {
      preemptible = var.vm_preemptible
    }
  }

  allocation_policy {
    zones = [var.default_zone]
  }

  scale_policy {
    fixed_scale {
      size = var.instance_group_size
    }
  }

  deploy_policy {
    max_unavailable = 1
    max_creating    = 3
    max_expansion   = 3
    max_deleting    = 1
  }

  health_check {
    interval            = 10
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2

    http_options {
      port = 80
      path = "/"
    }
  }

  load_balancer {
    target_group_name        = "lamp-target-group"
    target_group_description = "Target group for the LAMP instance group"
  }
}