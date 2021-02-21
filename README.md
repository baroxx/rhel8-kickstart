# rhel8-kickstart

You can modify and use the Kickstart file (anaconda-ks.cfg) to automate the installation.

Source: [RedHat documentation](https://access.redhat.com/login?redirectTo=https%3A%2F%2Faccess.redhat.com%2Fdocumentation%2Fen-us%2Fred_hat_enterprise_linux%2F7%2Fhtml%2Finstallation_guide%2Fsect-simple-install-kickstart)

## Preparation of the Kickstart file

You can use the [Kickstart Generator](https://access.redhat.com/labs/kickstartconfig/) from Red Hat and do some adjustments (for example manage the subscription with [RHSM](https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/8/html/performing_an_advanced_rhel_installation/register-and-install-from-cdn-kickstart_installing-rhel-as-an-experienced-user)). 

## Preparation of the Image

The following instructions show the required steps to create a bootable image with a Kickstart file for an automated installation.

Download the ISO: https://developers.redhat.com/products/rhel/download

```
# Mount the iso:
mount -o loop /tmp/rhel-server-7.3-x86_64-dvd.iso /mnt/

# Copy the content to a working directory:
cp -avRf /mnt/* /home/bastian/rhel-install/

# Unmount the ISO:
umount /mnt

# Copy the Kickstart file into the working directory:
cp /root/anaconda-ks.cfg /home/bastian/rhel-install/

# Get the volume name of the ISO: 
isoinfo -d -i ISONAME.iso | grep "Volume id" | \ sed -e 's/Volume id: //' -e 's/ /\\x20/g'

# Add the menu entry to the isolinux boot menu (see example below)
Mount the efi bootloader: 
mount /root/rhel-install/images/efiboot.img /mnt/

# Add the a menu entry for the Kickstart installation to the grub menu (see example below): 
nano /mnt/EFI/BOOT/grub.cfg

# Unmount the image: 
umount /mnt

# Create the new ISO (change the volume name, input dir and output file): 
mkisofs -untranslated-filenames -volid "RHEL-8-3-0-BaseOS-x86_64" -J -joliet-long -rational-rock -translation-table -input-charset utf-8 -b isolinux/isolinux.bin -c isolinux/boot.cat -no-emul-boot -boot-load-size 4 -boot-info-table -eltorito-alt-boot -e images/efiboot.img -no-emul-boot -o rhel8-ks.iso -graft-points /home/bastian/rhel-install/

# Make the new ISO bootable:
isohybrid --uefi rhel8-ks.iso
```