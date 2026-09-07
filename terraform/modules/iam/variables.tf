
variable "policy_actions" {
  description = "List of actions for the IAM policy"
  type        = list(string)
}

variable "policy_resources" {
  description = "List of resources for the IAM policy"
  type        = list(string)
}

variable "policy_name" {
  description = "Name of policy"
  type        = string
}