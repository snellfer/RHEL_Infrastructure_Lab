#!/bin/bash

# 1. Install ansible
dnf -y install ansible

# 2. Prepare the user ansible
useradd ansible
echo "ansible ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/ansible
chmod 0440 /etc/sudoers.d/ansible

# 3. Bake the SSH Key Handshake (Self-Trust)
# This allows the clones to trust each other immediately upon birth
mkdir -p /home/ansible/.ssh
chmod 700 /home/ansible/.ssh

# Generate the key as the ansible user
su - ansible -c "ssh-keygen -t ed25519 -N '' -f ~/.ssh/id_ed25519"

# Add its own public key to its authorized_keys
su - ansible -c "cat ~/.ssh/id_ed25519.pub >> ~/.ssh/authorized_keys"
su - ansible -c "chmod 600 ~/.ssh/authorized_keys"

# Ensure permissions are correct
chown -R ansible:ansible /home/ansible/.ssh

# 4. Identity Reset (The "SysAdmin Wipe")
# These commands prepare the master image for cloning
truncate -s 0 /etc/machine-id
rm -f /etc/ssh/ssh_host_*_key*

# 1. Install the building blocks
dnf install -y kernel-devel kernel-headers gcc make perl elfutils-libelf-devel

# 2. Add the VirtualBox repository to get the guest tools directly
cat <<'EOF' > /etc/yum.repos.d/virtualbox.repo
[virtualbox]
name=Fedora $releasever - $basearch - VirtualBox
baseurl=https://download.virtualbox.org/virtualbox/rpm/fedora/$releasever/$basearch
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://virtualbox.org
EOF

# 3. Install the Guest Additions without ever touching an ISO
dnf install -y VirtualBox-guest-additions

# Clear history
history -c && history -w

echo "Golden Image is ready. Shut down and clone now."

