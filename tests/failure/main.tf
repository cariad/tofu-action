# The plan always fails, with an error that names the job, so CI can find the
# job's own comment.
variable "job" {
  type = string

  validation {
    condition     = var.job == ""
    error_message = "This plan fails on purpose for ${var.job}."
  }
}
