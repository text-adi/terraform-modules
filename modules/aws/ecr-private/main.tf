#-------------------------------------------------
#
# Private ECR - Module:
#   - Create
#   - Settings scanning configuration
#   - Settings lifecycle policy
#
#-------------------------------------------------

# Create repository
resource "aws_ecr_repository" "this" {
  name                 = var.name
  image_tag_mutability = var.tag-immutability-image
  image_scanning_configuration {
    scan_on_push = false
  }
}

# Scanning configuration
resource "aws_ecr_registry_scanning_configuration" "this" {
  scan_type = "BASIC"
  rule {
    scan_frequency = "SCAN_ON_PUSH"
    repository_filter {
      filter      = "*"
      filter_type = "WILDCARD"
    }
  }
}

# Lifecycle policy
resource "aws_ecr_lifecycle_policy" "this" {
  repository = aws_ecr_repository.this.name
  policy     = jsonencode({
    rules = [
      for item in var.lifecycle-image :
      {
        rulePriority = 1,
        description  = "Delete old images for ${item.name}",
        selection    = {
          tagStatus      = "tagged",
          countType      = "imageCountMoreThan",
          tagPatternList = [
            "*-${item.name}"
          ],
          countNumber = item.delete_more_count
        },
        action = {
          type = "expire"
        }
      }
    ]
  })

}