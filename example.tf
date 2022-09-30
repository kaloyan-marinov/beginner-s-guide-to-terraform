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

# # a domain
# resource "linode_domain" "example_domain" {
#   domain    = "mysuperawesomesite.com"
#   soa_email = "sid@devopsdirective.com"
#   type      = "master"
# }

# a domain record
# (whose purpose is to point our domain
# to the IP address of this instance that we created)
resource "linode_domain_record" "example_domain_record" {
  # domain_id = linode_domain.example_domain.id
  domain_id   = var.domain_id
  name        = "www"
  record_type = "A"
  target      = linode_instance.example_instance.ip_address
  # Set time-to-live (=: TTL),
  # which configures how many seconds the DNS system should cache this record.
  ttl_sec = 300
}

# a firewall

# variables
variable "token" {
  # Empty!
}

variable "root_pass" {
  # Empty!
}

variable "domain_id" {
  # Empty!
}
