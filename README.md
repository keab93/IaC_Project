# IaC Project

Cloud deployment: Two Azure Container Instances running a public web container with a simple script for automated user management.

## Azure Cloud Shell

After placing the user management container images in ACR and updating variables.tf with correct image names, you can deploy the infrastructure using Azure Cloud Shell:

```bash
git clone https://github.com/keab93/IaC_project.git
cd IaC_project/terraform

terraform init
terraform apply
```

To clean up:

```bash
terraform destroy
```
