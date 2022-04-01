# RHEL8 - Server

You can modify and use the Kickstart file (anaconda-ks.cfg) to automate the installation.

Source: [RedHat documentation](https://access.redhat.com/login?redirectTo=https%3A%2F%2Faccess.redhat.com%2Fdocumentation%2Fen-us%2Fred_hat_enterprise_linux%2F7%2Fhtml%2Finstallation_guide%2Fsect-simple-install-kickstart)

## install.sh

You can use the bash script to create a virtual machine using the kickstart file. The ISO must be in a directory which is accessible by qemu (for example /opt).

## Kickstart file

The Kickstar file is a basic setup of a default RHEL8 server whithout any further installations.