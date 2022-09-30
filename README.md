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

# Summary

The full power of Infrastructure as Code (IaC) is that it enables us to:

1. spin up resources

2. get them all configured properly

3. track changes for those over time
   (as we [may] need to modify them, add additional things, etc.)

# Topics for further study

1. we used this top-level `example.tf` file,
   and included all of our resources within it

   if we wanted to build our code in such a way that it could be re-usable,
   we would use a feature called _Terraform modules_

2. this local `terraform.tfstate` file;
   by default, it stores our state locally

   but if we wanted to work with a team,
   we would want to store that remotely somewhere

   [and one good place to do that is within Terraform Cloud],
   where you can store your state files and all your sensitive information

3. finally, not every project will be starting from scratch;
   you may have a bunch of resources already provisioned within your Linode account;

   in the next video,
   we're actually going to go through and take some resources,
   which were provisioned ahead of time [(= "outside of the Terraform process")],
   and import them into a Terraform configuration
   [so] that we are able to use and manage them with IaC
