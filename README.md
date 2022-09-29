# Introduction

```
cp \
    terraform.tfvars.template \
    terraform.tfvars

# Edit the `terraform.tfvars` file according to the instructions,
# which are within that file.
```

# The basic Terraform workflow

1. `terraform init`

   is going to:
   
   - download the source code for that provider
   
   - create a `.terraform` directory and a `terraform.lock.hcl` file

2. `terraform plan`

   is going to say that there's
   "No changes. Your infrastructure matches the configuration."
   (because we haven't defined/declared any resources)