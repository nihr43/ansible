#!/bin/sh

# bootstraps FreeBSD hosts for use with ansible
# bsd clients depend python27
# ansible hosts file needs to spec py27 as well


TMP_DIR=`mktemp -d`


# here we ssh into hypervisor, grab mac address of guest

UUID=$(ssh -o StrictHostKeyChecking=no 192.168.1.100 -p 2222 -- vm info $1 | grep "fixed-mac-address" | awk '{print $2}' | awk -F ':' '{print $4$5$6}' | head -n1)
UUID=$(echo -n $UUID".localdomain")


# install python for ansible

ssh -o StrictHostKeyChecking=no $UUID -- pkg install -y python27


# grab rc.conf, modify it locally, send it back

scp $UUID:/etc/rc.conf $TMP_DIR/rc.conf
sed -i -e "s|hostname=.*|hostname=\"$1\"|" $TMP_DIR/rc.conf
scp $TMP_DIR/rc.conf $UUID:/etc/rc.conf


ssh $UUID reboot
rm -rf $TMP_DIR
