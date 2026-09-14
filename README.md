# IaC Project

## Project description and purpouse

Cloud deployment of a web server and a user-provisioning job using ACI and ACR on Azure with Terraform as the main IaC tool. Docker images are first created and then pushed to Azure Container Registry (ACR) before being deployed to Azure Container Instances (ACI) using terraform. The web server runs as its own long-running container group; user provisioning runs as a separate one-shot container group that executes a bash script to create users and set passwords, then exits.

A CI/CD pipeline in Azure is linked to this repository using GitHub Actions to automate the validation, build and deployment process. After pushing to this repository this workflow has the ability to create, modify or remove the resources on Azure depending on the new Terraform changes. 

## Container Groups

The two containers used to live in a single container group. I have split them into separate container groups because they have different lifecycles.

### TODO

- The container batch job should run against a VM (via cloud-init) in order to get persistent filesystem state.
- Pass ACR name as a variable instead of hardcoding it.

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
