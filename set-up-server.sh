#!/bin/bash
echo "Hello world (from my Linode)!" > index.html

# Set up a simple web server using the `busybox` Linux utility.
# (When the user who initiated this command logs out,
# the initiated process will not get terminated - thanks to the utilization of `nohup`.)
nohup busybox httpd -f -p 80 &
