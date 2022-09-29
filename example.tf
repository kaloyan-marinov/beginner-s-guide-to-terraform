terraform {
  required_providers {
    linode = {
      # The following points to where this is defined within the Hashicorp Registry.
      source = "linode/linode"
    }
  }
}

provider "linode" {
  token = vars.token
  # Because I'm deploying a firewall, which is a "beta resource",
  # we need to specify that we are going to use the beta version of the API.
  api_version = "v4beta"
}

# a linode server

# a domain

# a domain record

# a firewall

# variables
variable "token" {
  # Empty!
}
