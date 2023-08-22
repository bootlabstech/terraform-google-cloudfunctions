variable "project_id" {
  type = string
}
variable "region" {
  type = string
}
variable "vpc_connector" {
  type = string
}

variable "function_name" {
  type = string
}
variable "function_runtime" {
  type = string
}
variable "entry_point" {
  type = string
}
variable "archive_bucket" {
  type = string
}
variable "archive_object" {
  type = string
}
variable "description" {
  type = string
}
variable "available_memory_mb" {
  type = number
}
variable "pubsub_topic" {
  type = string
}
variable "bigquery_dataset" {
  type = string
}
variable "bigquery_table" {
  type = string
}




