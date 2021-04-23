A Simple Terraform Deployment
=============================

This terraform deployment consist multiple modules deployed as a single unit of code.

The deployment includes two environments: `dev`, `production`

## State File Management

The configuration for the remote terraform state is contained in the `backends` folder:
```
❯ lt backends
backends
├── dev.hcl
└── production.hcl

❯ cat backends/dev.hcl
bucket = "111122223333-us-west-2-tf-state"
key    = "dev/simple-deployment/terraform.tfstate"
region = "us-west-2"

❯ cat backends/production.hcl
bucket = "111122223333-us-west-2-tf-state"
key    = "production/simple-deployment/terraform.tfstate"
region = "us-west-2"
```

You will need to run `terraform init ...` for every deployment:
```
# dev
terraform init -backend-config=backends/dev.hcl

# production
terraform init -backend-config=backends/production.hcl
```

Note that terraform doesn't provide a mechanism to determine which backend is currently configured; and the configuration cannot be overriden when running `plan` or `apply`.

## Deploying Infrastructure in the `dev` Environment

To deploy infrastructure in `dev`, execute the following commands:

```
terraform init -backend-config=backends/dev.hcl
terraform plan -var-file=environments/dev.tfvars
terraform apply -var-file=environments/dev.tfvars
```

## Deploying Infrastructure in the `production` Environment

To deploy infrastructure in `production`, execute the following commands:

```
terraform init -backend-config=backends/production.hcl
terraform plan -var-file=environments/production.tfvars
terraform apply -var-file=environments/production.tfvars
```

