# The plan adds one resource, and shows the job's name, so CI can find the job's
# own comment.
variable "job" {
  type = string
}

resource "terraform_data" "test" {
  input = var.job
}
