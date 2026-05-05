#!/bin/bash

# 1. Install ansible
dnf install ansible-core

# 2. Prepare the user ansible
useradd -m ansible
echo "ansible ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/ansible

# 4. Identity Reset (The "SysAdmin Wipe")
# These commands prepare the master image for cloning
truncate -s 0 /etc/machine-id
rm -f /etc/ssh/ssh_host_*_key*


# Clear history
history -c && history -w

echo "Golden Image is ready. Shut down and clone now."

