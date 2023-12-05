# aws-terraform-ci-cd
# Project Directory Structure

```plaintext
/aws-terraform-ci-cd
|-- .github
|   `-- workflows
|       `-- terraform-ci-cd.yml
|-- environments
|   |-- dev
|   |   |-- main.tf
|   |   `-- terraform.tfvars
|   |-- hml
|   |   |-- main.tf
|   |   `-- terraform.tfvars
|   `-- prod
|       |-- main.tf
|       `-- terraform.tfvars
|-- modules
|   |-- network
|   |   `-- main.tf
|   |-- waf
|   |   `-- main.tf
|   `-- api_gateway
|       `-- main.tf
|-- ansible
|   |-- playbook.yml
|   |-- roles
|   |   |-- common
|   |   |   |-- tasks
|   |   |   |   `-- main.yml
|   |   `-- backend_setup
|   |       |-- tasks
|   |       |   `-- main.yml
|   |       `-- templates
|   |           `-- backend_config_file.j2
|-- .gitignore
|-- README.md
|-- terraform.tfstate
|-- terraform.tfstate.backup
|-- main.tf
|-- variables.tf
|-- outputs.tf

