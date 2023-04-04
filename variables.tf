variable "project_id" {
 type = string
}
variable "host_project_id" {
 type = string
}
variable "region" {
  type = string
}
variable "bucket_name" {
  type = string
}
variable "vpc_connector" {
  type = string
}
variable "outputpath" {
  type = string
  default = "/tmp/function.zip"
}
variable "function_name" {
  type = string
  default = "function-trigger-on-gcs"
}
variable "function_runtime" {
  type = string
}
variable "entry_point" {
  type = string
}