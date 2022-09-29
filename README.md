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
   "1 [resource] to add[/provision]"

3. `terraform apply`

   is going to provision the planned "linode_instance" resource:

   - creates a `terraform.tfstate` file

     (

     [that file is where] Terraform stores information about your configuration;

     by default, [that file] will be stored locally;

     if you want to work on a Terraform configuration with a team,
     you would need to store that [file] remotely somewhere;

     Terraform provides a cloud offering that enables you to
     store your state files in their system
     and collaborate with team members from within that ...
     [, but that is not the only remote location
     where your "state file(s)" can be stored]

     ---

     it's also important to point out that
     [the] "state file" will contain sensitive information
     (such as your passwords or tokens within it)

     so you'll want to take the necessary precautions to keep that file protected

     )

   - asks for confirmation at the command line (need to type 'yes' and press [Enter])
