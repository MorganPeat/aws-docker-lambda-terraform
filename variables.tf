variable "aws_role_arn" {
  description = "ARN of the role that the AWS terraform provider uses"
  type        = string
}

variable "image_uri" {
  description = "URI of the image to be deployed in AWS Lambda"
  type        = string
  default     = "303871294183.dkr.ecr.eu-west-2.amazonaws.com/mp-demo-config:latest"
}