
terraform {
  backend "s3" {
    bucket       = "guvi-terraform-state-055280968385-2026"
    key          = "project-03/terraform.tfstate"
    region       = "ap-south-1"
    encrypt      = true
    use_lockfile = true
  }
}
