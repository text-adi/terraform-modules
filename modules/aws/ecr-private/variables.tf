variable "name" {
  description = "Назва репозиторію, який буду створена"
  type        = string
}

variable "tag-immutability-image" {
  description = "Чи можна надсилати в repository один і той самий image повторно? Стандарта поведінка - Заборонено"
  type        = string
  default     = "IMMUTABLE"
}

variable "lifecycle-image" {
  description = "Теги, які будуть використовувати під час розробку проекту, та їх життєвий цикл"
  type        = list(object({
    name              = string
    delete_more_count = number
  }))
  default = [
    {
      name              = "prod",
      delete_more_count = 3
    },
    {
      name              = "dev",
      delete_more_count = 1
    }
  ]
}
