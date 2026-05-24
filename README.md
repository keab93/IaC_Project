# IaC Project

## Project description and purpouse

Cloud deployment of web and user management services using ACI and ACR on Azure with Terraform as the main IaC tool. Docker images are first created and then pushed to Azure Container Registry (ACR) before being deployed to Azure Container Instances (ACI) using terraform. One of the containers runs a web server and the other one runs a user management service that with an automated bash script that creates users and sets passwords for them. 

A CI/CD pipeline in Azure is linked to this repository using GitHub Actions to automate the validation, build and deployment process. After pushing to this repository this workflow has the ability to create, modify or remove the resources on Azure depending on the new Terraform changes. 

## Azure Cloud Shell

After placing the user management container images in ACR and updating variables.tf with correct image names, you can deploy the infrastructure using Azure Cloud Shell CLI:

```bash
git clone https://github.com/keab93/IaC_project.git
cd IaC_project/terraform

terraform init
terraform apply
```

To destroy:

```bash
terraform destroy
```

# System Requirements

- Azure Cloud CLI
- Docker
- Terraform
- Git
- Bash
