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

  # Concept known as "provisioners".
  # Terraform allows us to take certain actions
  # after a resource has been deployed.
  # Importantly,
  # "provisioners only occur upon the first creation of" the resource in question.
  #
  # In this case, once our Linode server comes up,
  # we want to run a script that will start a web server for us
  # so that we will be able to access it from the browser.

  # Copy the `set-up-server.sh` script onto the filesystem of the Linode server.
  provisioner "file" {
    source      = "set-up-server.sh"
    destination = "/tmp/set-up-server.sh"

    # Give it a way for Terraform to connect to this instance.
    connection {
      type     = "ssh"
      host     = self.ip_address # instead of `linode_instance.example_instance.ip_address`
      user     = "root"
      password = var.root_pass
    }
  }

  # Invoke the copied `set-up-server.sh` script.
  provisioner "remote-exec" {
    # Specify the actual shell command that gets executed on the server.
    # (I found that, when I was testing this, it would run [the 2nd command below]
    # and, before it had even fully started that web server,
    # Terraform would close the connection, which would cause it to not work properly.
    # So, by [adding the 3rd command below]
    # before closing my Terraform "remote-exec" connection,
    # it's able to properly start that script.)
    inline = [
      "chmod +x /tmp/set-up-server.sh",
      "/tmp/set-up-server.sh",
      "sleep 1",
    ]

    connection {
      type     = "ssh"
      host     = self.ip_address # instead of `linode_instance.example_instance.ip_address`
      user     = "root"
      password = var.root_pass
    }
  }
}

# [
# Importantly,
# add the Linode nameservers
# to the DNS setup for the domain specified below,
# and this addition has to be done (on the website) where you purchased the domain.
# Do bear in mind that,
# when you created DNS records, they can take up to 48 hours to propagate.
# ]
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
# (whose purpose is to allow inbound traffic on port 80,
# which is where we're going to set up a server
# that's gonna run inside of our `resource "linode_instance"`)
resource "linode_firewall" "example_firewall" {
  label = "example_firewall_label"

  inbound {
    label    = "allow-http"
    action   = "ACCEPT"
    protocol = "TCP"
    ports    = "80"
    # Set the allowable IP addresses that [may] make this type of request.
    ipv4 = ["0.0.0.0/0"]
    ipv6 = ["ff00::/8"]
  }

  # Prevent anything, which is different from the above-configured inbound rule,
  # from making it to our instance.
  inbound_policy = "DROP"

  outbound_policy = "ACCEPT"

  linodes = [linode_instance.example_instance.id]
}

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
