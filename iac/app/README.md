# Deploy puma-redeploy-test-app using Terraform

## Requirements
* Terraform
* AWS Account
* Configure AWS profile names app_deployer

## Deploy App

```shell
cd iac/app
terraform init
terraform apply
```

## Destroy App

```shell
terraform destroy
```
