#!/bin/sh
#
## refreshes unbound hostfile from etcd

[ "$1" != "now" ] && sleep `jot -r 1 0 60`

hash etcdctl jq || exit 1

export ETCDCTL_API=2
ETCD="10.0.0.34"


# get all records, convert to form -- local-data: "example.com A 10.0.0.1"

RECORDS=`etcdctl --endpoints=http://${ETCD}:2379 ls /unbound` || exit 1

for i in `echo $RECORDS` ; do

  JSON=`etcdctl --endpoints=http://${ETCD}:2379 get "$i"`
  HOSTNAME="`echo $JSON | jq -r .hostname`"
  IP="`echo $JSON | jq -r .ip`"

  echo "local-data: \"${HOSTNAME} A ${IP}\""

done > /usr/local/etc/unbound/records.conf

service unbound reload
