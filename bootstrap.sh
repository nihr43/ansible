#!/bin/sh

# bootstraps FreeBSD hosts for use with ansible
# bsd clients depend python27
# ansible hosts file needs to spec py27 as well

# here we ssh into hypervisor, grab mac address of guest, ssh into guest, set correct hostname


UUID=$(ssh -o StrictHostKeyChecking=no 192.168.1.100 -- vm info $1 | grep "fixed-mac-address" | awk '{print $2}' | awk -F ':' '{print $4$5$6}')
UUID=$(echo -n $UUID".localdomain")
ssh -o StrictHostKeyChecking=no $UUID -- pkg install -y python27

scp $UUID:/etc/rc.conf /tmp/rc.conf
sed -i -e "s|hostname=.*|hostname=\"$1\"|" /tmp/rc.conf
scp /tmp/rc.conf $UUID:/etc/rc.conf

ssh $UUID reboot

rm /tmp/rc.conf
