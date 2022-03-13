# RHEL8 Kickstart

This repository contains examples for setups with a Kickstart file.

- [rhel8-server/](rhel8-server/) - a default server installation

# Preparation of the Kickstart file

The Kickstart files in the subdirectories are for a specific use case. You can use [rhel8-server/anaconda-ks.cfg](rhel8-server/anaconda-ks.cfg) as a template for your use case. The root password and the subscription data must be changes.

You can also use the [Kickstart Generator](https://access.redhat.com/labs/kickstartconfig/) from Red Hat and do some adjustments (for example manage the subscription with [RHSM](https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/8/html/performing_an_advanced_rhel_installation/register-and-install-from-cdn-kickstart_installing-rhel-as-an-experienced-user)). 

# Preparation of the Image

The following instructions show the required steps to create a bootable image with a Kickstart file for an automated installation.

Download the ISO: https://developers.redhat.com/products/rhel/download

```
# Mount the iso:
mount -o loop /tmp/rhel-8.5-x86_64-dvd.iso /mnt/

# Copy the content to a working directory:
cp -avRf /mnt/* /home/bastian/rhel-install/

# Unmount the ISO:
umount /mnt

# Copy the Kickstart file into the working directory:
cp /root/anaconda-ks.cfg /home/bastian/rhel-install/

# Get the volume name of the ISO: 
isoinfo -d -i ISONAME.iso | grep "Volume id" | \ sed -e 's/Volume id: //' -e 's/ /\\x20/g'

# Add the menu entry to the isolinux boot menu (see example below)

# Mount the efi bootloader: 
mount /root/rhel-install/images/efiboot.img /mnt/

# Add the a menu entry for the Kickstart installation to the grub menu (see example below): 
nano /mnt/EFI/BOOT/grub.cfg

# Unmount the image: 
umount /mnt

# Create the new ISO (change the volume name, input dir and output file): 
mkisofs -untranslated-filenames -volid "RHEL-8-5-0-BaseOS-x86_64" -J -joliet-long -rational-rock -translation-table -input-charset utf-8 -b isolinux/isolinux.bin -c isolinux/boot.cat -no-emul-boot -boot-load-size 4 -boot-info-table -eltorito-alt-boot -e images/efiboot.img -no-emul-boot -o rhel8-ks.iso -graft-points /home/bastian/rhel-install/

# Make the new ISO bootable:
isohybrid --uefi rhel8-ks.iso
```

**Example isolinux boot menu**

Set the inst.stage2=hd:LABEL= and inst.ks=hd:LABEL= values to the volume name of the ISO, see step 6
```
label kickstart
  menu label ^Kickstart Installation of RHEL8.5
  kernel vmlinuz
  append initrd=initrd.img inst.stage2=hd:LABEL=RHEL-8-5-0-BaseOS-x86_64 inst.ks=hd:LABEL=RHEL-8-5-0-BaseOS-x86_64:/anaconda-ks.cfg
```

**Example grub boot menu**

Set the inst.stage2=hd:LABEL= and inst.ks=hd:LABEL= values to the volume name of the ISO, see step 6
```
menuentry 'Kickstart Installation of RHEL8.5' --class fedora --class gnu-linux --class gnu --class os {
        linuxefi /images/pxeboot/vmlinuz inst.stage2=hd:LABEL=RHEL-8-5-0-BaseOS-x86_64 inst.ks=hd:LABEL=RHEL-8-5-0-BaseOS-x86_64:/anaconda-ks.cfg
        initrdefi /images/pxeboot/initrd.img
}
```