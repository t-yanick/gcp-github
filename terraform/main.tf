provider "google" {
  project = var.project_id
  region  = var.region
}

resource "google_compute_network" "vpc_network" {
  name = "my-vpc-network"
}

resource "google_compute_subnetwork" "public_subnet" {
  name          = "my-public-subnet"
  ip_cidr_range = "10.0.1.0/24"
  region        = var.region
  network       = google_compute_network.vpc_network.name
}

resource "google_compute_subnetwork" "private_subnet" {
  name          = "my-private-subnet"
  ip_cidr_range = "10.0.2.0/24"
  region        = var.region
  network       = google_compute_network.vpc_network.name
}

resource "google_storage_bucket" "gcs_bucket" {
  name     = "my-gcs-bucket-${var.project_id}"
  location = var.region
}

resource "google_bigquery_dataset" "dataset" {
  dataset_id = "my_dataset"
  location   = var.region
}

resource "google_cloud_run_service" "cloud_run_service" {
  name     = "my-cloud-run-service"
  location = var.region

  template {
    spec {
      containers {
        image = "gcr.io/google-containers/hello-app:1.0"
      }
    }
  }
}