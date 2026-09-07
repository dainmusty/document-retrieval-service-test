variable "subnet_ids" {
  type = list(string)
}
variable "iam_instance_profile_name" {
  type = string
}
variable "web_sg_id" {
  type = string
}
variable "ami_id" {
  type = string
}
variable "instance_type" {
  type = string
}
variable "key_name" {
  type = string
}
variable "user_data" {
  type = string
}
variable "launch_template_name" {
  type = string
}
variable "asg_name" {
  type = string
}
variable "min_size" {
  type = number
}
variable "max_size" {
  type = number
}
variable "desired_capacity" {
  type = number
}
variable "target_group_arn" {
  type = string
}
