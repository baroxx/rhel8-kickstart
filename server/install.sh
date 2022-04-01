#!/usr/bin/env bash

## Pre-defined variables
echo ""
MEM_SIZE=4096
VCPUS=2
OS_VARIANT="rhl8.0"
ISO_FILE="/opt/rhel-8.5-x86_64-dvd.iso"

echo -en "Enter vm name: "
read VM_NAME
OS_TYPE="linux"
echo -en "Enter virtual disk size : "
read DISK_SIZE

sudo virt-install \
     --name ${VM_NAME} \
     --memory=${MEM_SIZE} \
     --vcpus=${VCPUS} \
     --os-type ${OS_TYPE} \
     --location ${ISO_FILE} \
     --disk size=${DISK_SIZE}  \
     --graphics=none \
     --os-variant=${OS_VARIANT} \
     --initrd-inject ./anaconda-ks.cfg \
     --extra-args="ks=file:/anaconda-ks.cfg console=tty0 console=ttyS0,115200n8"
