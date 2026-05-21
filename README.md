# IaC Project

Cloud deploymen using ACI and ACR on Azure using Terraform as the main IaC tool. Github actions for CI/CD of the Terraform automation.

## Azure Cloud Shell

After placing the user management container images in ACR and updating variables.tf with correct image names, you can deploy the infrastructure using Azure Cloud Shell:

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
