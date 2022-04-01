# RHEL8 - OpenStack

This is an example for an OpenStack setup with a controller and a compute node. 

# Kickstart files

There are two Kickstart files which are both installing the required repositories and tools for the specific node type:

- [anaconda-ks-controller.cfg](anaconda-ks-controller.cfg) - Setup of the controll plane
- [anaconda-ks-compute.cfg](anaconda-ks-compute.cfg) - Setup of a compute node

# Preperation

The scripts for OpenStack are provided by the repository [rhel8-openstack](https://github.com/baroxx/rhel8-openstack). 

1. Clone this repository
1. Clone [rhel8-openstack](https://github.com/baroxx/rhel8-openstack) to this directory (rhel8-openstack)
1. Prepare the image (described in the main README) but in addition perform the following steps after copying the content of the ISO to the working directory
1. You can also create two menu entries in grub.cfg (one for the [controller](anaconda-ks-controller.cfg) and one for [compute nodes](anaconda-ks-compute.cfg))

```
# "/home/bastian/rhel-install" is the working directory. Adjust accordingly 
cp -r ./rhel8-openstack /home/bastian/rhel-install/isolinux/rhel8-openstack
```

# Install script

You can use the bash script to create virtual machines using the kickstart files. The script requires an RHEL8 ISO. The ISO must be in a directory which is accessible by qemu (for example /opt). 

One input parameter is the node type (controller or compute). The script will then use the corresponding Kickstart file.