resource "google_project_service" "funcapi" {
  project = var.project_id
  service = "cloudfunctions.googleapis.com"
}

# Create the Cloud function triggered by a `Finalize` event on the bucket
resource "google_cloudfunctions_function" "function" {
  project                       = var.project_id
  name                          = var.function_name
  description                   = var.description
  runtime                       = var.function_runtime
  region                        = var.region

  available_memory_mb   = var.available_memory_mb

  ingress_settings      = "ALLOW_INTERNAL_ONLY"
    event_trigger {
    event_type = "providers/cloud.pubsub/eventTypes/topic.publish"
    resource   = var.pubsub_topic
  }

  # Get the source code of the cloud function as a Zip compression
  source_archive_bucket = var.archive_bucket
  source_archive_object = var.archive_object

 
  entry_point           = var.entry_point
  environment_variables = {
    BIGQUERY_DATASET = var.bigquery_dataset
    BIGQUERY_TABLE = var.bigquery_table
  }

  depends_on = [
    google_project_service.funcapi,
  ]
  lifecycle {
    ignore_changes = [labels]
  }
}


