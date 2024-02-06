variable "name" {
  description = "Name bucket"
  type        = string
}

variable "object_ownership" {
  description = "Спосіб встановлення доступу до файлів. Рекомендується використовувати BucketOwnerEnforced"
  type        = string
  default     = "BucketOwnerEnforced"
}

variable "public_access_settings" {
  description = "Публічні доступи до сховища S3. Не рекомендується надавати публічний доступ. Якщо потрібно public доступ - конфігуруй через CloudFront"

  type = object({
    block_public_acls       = bool
    block_public_policy     = bool
    ignore_public_acls      = bool
    restrict_public_buckets = bool
  })

  default = {
    block_public_acls       = true
    block_public_policy     = true
    ignore_public_acls      = true
    restrict_public_buckets = true
  }
}
variable "versioning_configuration_status" {
  description = "Версії файлів в сховищі S3. Рекомендується використовувати версіювання, задля можливості відновлення файлів"
  type = string
  default = "Enabled"
}