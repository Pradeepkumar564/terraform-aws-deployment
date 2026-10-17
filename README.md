\# AWS Infrastructure Automation Using Terraform \& GitHub Actions



\## Project Overview



This project demonstrates Infrastructure as Code (IaC) using Terraform to define AWS infrastructure and GitHub Actions to automate validation and planning.



\*\*Project status:\*\* Terraform configuration validated and plan reviewed. Infrastructure deployment has not been performed.



\## Technologies Used



\- Amazon Web Services (AWS)

\- Terraform

\- Git and GitHub

\- GitHub Actions

\- AWS IAM and OpenID Connect (OIDC)

\- Amazon VPC, EC2, S3, and Elastic IP



\## Architecture



The Terraform configuration defines the following resources in the AWS Mumbai region (`ap-south-1`):



\- One VPC with CIDR `10.0.0.0/16`

\- Two public subnets

\- An Internet Gateway

\- A public route table and subnet associations

\- A security group allowing HTTP traffic on port 80

\- An EC2 instance using Amazon Linux 2023 and Nginx

\- An IAM role and instance profile for EC2

\- An Elastic IP

\- An S3 application bucket with versioning, encryption, and public access blocking



These resources are defined in code; they have not been deployed by this project.



\## Project Structure



\- `main.tf` — Root module and module calls

\- `providers.tf` — AWS provider configuration

\- `backend.tf` — S3 remote state configuration

\- `variables.tf` — Input variables

\- `outputs.tf` — Output definitions

\- `s3.tf` — Application S3 bucket configuration

\- `modules/networking/` — VPC, subnets, Internet Gateway, and routing

\- `modules/compute/` — EC2, security group, Elastic IP, and IAM resources

\- `.github/workflows/terraform.yml` — GitHub Actions workflow



\## Remote State



Terraform remote state is configured to use an S3 bucket with encryption and versioning. The backend also enables Terraform's S3 lockfile mechanism.



\## CI/CD Workflow



GitHub Actions uses AWS OIDC authentication instead of storing long-lived AWS access keys in GitHub secrets. The workflow runs Terraform formatting checks, initialization, validation, and planning.



The workflow is intentionally \*\*plan-only\*\*. It does not execute `terraform apply`.



\## Validation and Plan Results



\- `terraform fmt -check -recursive` — Passed

\- `terraform validate` — Passed

\- `terraform plan` — Passed

\- Planned changes — 18 resources to add, 0 to change, 0 to destroy



The Terraform plan represents proposed changes only. No infrastructure has been deployed using terraform apply.



\## Security Considerations



\- S3 public access is blocked for the application bucket.

\- S3 server-side encryption and versioning are configured.

\- EC2 metadata access requires IMDSv2.

\- SSH access is not opened to the internet by default.

\- GitHub Actions authenticates through OIDC.

\- Review IAM permissions and AWS billing before any future deployment.



\## Cost and Deployment Safety



This project has not been applied to AWS because the project spending budget is ₹0. AWS credits do not guarantee that all services are free.



Before any future deployment, review AWS pricing, credits, and service restrictions. A deployment must only be performed with explicit authorization and an approved budget.



\## Conclusion



This project demonstrates Terraform-based AWS infrastructure design and GitHub Actions automation, including remote state management and OIDC authentication. The configuration has been validated and a deployment plan generated without applying the planned infrastructure.

