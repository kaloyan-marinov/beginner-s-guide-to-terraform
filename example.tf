terraform {
  required_providers {
    linode = {
      # The following points to where this is defined within the Hashicorp Registry.
      source = "linode/linode"
    }
  }
}

provider "linode" {
  token = var.token
  # Because I'm deploying a firewall, which is a "beta resource",
  # we need to specify that we are going to use the beta version of the API.
  api_version = "v4beta"
}

# a linode server
resource "linode_instance" "example_instance" {
  # The following will be used as a label inside of the Linode interface.
  label = "example_instance_label"

  # The following is the operating system - ahem, the image! - that we'll be running.
  image = "linode/ubuntu18.04"

  region = "us-central"
  type   = "g6-standard-1"

  # If we had an SSH key and wanted to use that method to SSH into the machine,
  # we could include it here:
  # authorized_keys = ["ssh-rsa AAAA...Gw** user@example.local"]

  root_pass = var.root_pass
}

# a domain

# a domain record

# a firewall

# variables
variable "token" {
  # Empty!
}

variable "root_pass" {
  # Empty!
}
