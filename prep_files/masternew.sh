
#!/bin/bash

# 1. Install your ansible
dnf install -y ansible-core

# 2. Setup the user
useradd -m ansible
echo "ansible ALL=(ALL) NOPASSWD:ALL" | tee /etc/sudoers.d/ansible
chmod 0440 /etc/sudoers.d/ansible


# This forces the clone to get a new IP and ID
truncate -s 0 /etc/machine-id

# Cleanup history
history -c
echo "Done. Shut down and clone now."

