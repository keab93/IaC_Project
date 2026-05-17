# IaC Project

Minimal Azure Terraform demo: one Ubuntu VM with Apache via cloud-init. With a simple script for automated user management. 

## Azure Cloud Shell (quick start)

```bash
git clone https://github.com/keab93
cd IaC_project/terraform

# create an SSH key in Cloud Shell
ssh-keygen -t ed25519 -f ~/.ssh/id_ed25519 -N ""

terraform init
terraform apply -var "ssh_public_key_path=~/.ssh/id_ed25519.pub"
```

To clean up:

```bash
terraform destroy
```
