resource "yandex_storage_bucket" "images" {
  bucket = var.bucket_name
  acl    = "public-read"
}

resource "yandex_storage_object" "homework_image" {
  bucket       = yandex_storage_bucket.images.bucket
  key          = var.image_object_key
  source       = var.image_source_path
  content_type = var.image_content_type
  acl          = "public-read"
}