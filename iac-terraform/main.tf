provider "google" {
  project     = "spacegames-devops-iac"
  region      = "us-east1"
  zone        = "us-east1-c"
  credentials = "${file("serviceaccount.yaml")}"
}

resource "google_folder" "LunarGame" {
  display_name = "LunarGame"
  parent       = "organizations/id"
}

resource "google_folder" "Development" {
  display_name = "Development"
  parent       = google_folder.LunarGame.name
}

resource "google_folder" "Test" {
  display_name = "Test"
  parent       = google_folder.LunarGame.name
}

resource "google_folder" "Production" {
  display_name = "Production"
  parent       = google_folder.LunarGame.name
}

resource "google_project" "spacegames-lunargame-dev" {
  name            = "LunarGame-Dev"
  project_id      = "spacegames-lunargame-dev"
  folder_id       = google_folder.Development.name
  billing_account = "id"
  auto_create_network = false
}

resource "google_project" "spacegames-lunargame-test" {
  name            = "LunarGame-Test"
  project_id      =      "spacegames-lunargame-test"
  folder_id       = google_folder.Test.name
  billing_account = "id"
  auto_create_network = false
}

resource "google_project" "spacegames-lunargame-prod" {
  name            = "LunarGame-Prod"
  project_id      = "spacegames-lunargame-prod"
  folder_id       = google_folder.Production.name
  billing_account = "id"
  auto_create_network=false
}