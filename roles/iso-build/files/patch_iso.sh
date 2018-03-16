#!/bin/sh

rm ./FreeBSD-11.1-RELEASE-bhyve64-autoinst.iso
mkdir /mnt/patched-iso
mkdir /mnt/iso

mount -t cd9660 /dev/$(mdconfig -f FreeBSD-11.1-RELEASE-amd64-disc1.iso) /mnt/iso

rsync -aq  /mnt/iso/ /mnt/patched-iso

# make modifications
cp ./installerconfig /mnt/patched-iso/etc/installerconfig
cp ./rc.local /mnt/patched-iso/etc/rc.local

# create a new ISO
VOL_ID=$(isoinfo -d -i FreeBSD-11.1-RELEASE-amd64-disc1.iso | grep "Volume id" | awk '{print $3}')
mkisofs -J -R -no-emul-boot -V "$VOL_ID" -b boot/cdboot -o FreeBSD-11.1-RELEASE-bhyve64-autoinst.iso /mnt/patched-iso

umount /mnt/iso
rm -rf /mnt/iso
rm -rf /mnt/patched-iso
