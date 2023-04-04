resource "google_project_service" "funcapi" {
  project = var.project_id
  service = "cloudfunctions.googleapis.com"
}
# resource "google_project_iam_binding" "cloud_functions_service_agent_binding" {
#   depends_on =[google_project_service.funcapi]
#   project = var.project_id
#   role    = "roles/vpcaccess.user"


#   members = var.members
# }

resource "google_storage_bucket" "bucket" {
  depends_on    = [data.archive_file.source]
  project       = var.project_id
  name          = var.bucket_name
  location      = var.region
  force_destroy = true

  uniform_bucket_level_access = true

}
resource "google_storage_bucket_object" "archive" {
  depends_on = [google_storage_bucket.bucket]
  name   = data.archive_file.source.output_path
  bucket = google_storage_bucket.bucket.name
  
  # Set the content of the zip file to the contents of the local directory
  source = data.archive_file.source.output_path
}



data "archive_file" "source" {
    type        = "zip"
    source_dir  = "function-code"
    output_path = "tmp/function.zip"
}

# Add source code zip to the Cloud Function's bucket


# Create the Cloud function triggered by a `Finalize` event on the bucket
resource "google_cloudfunctions_function" "function" {
    project               = var.project_id
    region                = var.region
    name                  = var.function_name
    runtime               = var.function_runtime  
    vpc_connector         = var.vpc_connector
    vpc_connector_egress_settings = "PRIVATE_RANGES_ONLY"

    # Get the source code of the cloud function as a Zip compression
    source_archive_bucket = google_storage_bucket_object.archive.bucket
    source_archive_object = google_storage_bucket_object.archive.name

    # Must match the function name in the cloud function `main.py` source code
    entry_point           = "helloWorld"
    trigger_http          = true
    

    # Dependencies are automatically inferred so these lines can be deleted
    depends_on            = [
       // google_storage_bucket.bucket,
        google_storage_bucket_object.archive,
        google_project_service.funcapi
    ]
}


