variable "project_id" {
 type = string
}
variable "region" {
  type = string
}
variable "filepath" {
  type = string
}
variable "outputpath" {
  type = string
  default = "/tmp/function.zip"
}
variable "name" {
  type = string
  default = "function-trigger-on-gcs"
}
variable "runtime" {
  type = string
}
variable "entry_point" {
  type = string
}