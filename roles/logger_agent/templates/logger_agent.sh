#!/bin/sh
#
## a log aggregation mechanism designed around gnu parallel

sleep `jot -r 1 0 1800`

NODES="{{ logger_nodes }}"
DATE=`date +%s`
KEY="/root/keys/id_ed25519"

# select a random logger node to copy our logs to
TARGET=`echo $NODES | tr ' ' '\n' | shuf | head -n1`

# make our target dir if not exists
ssh -i $KEY logger@$TARGET -- "[ -e /opt/log/`hostname -s` ] || mkdir -p /opt/log/`hostname -s`"

set -e

# copy and truncate logs
cd /var/log
find . -type f -exec scp -i $KEY {} logger@$TARGET:/opt/log/`hostname -s`/{}.$DATE \; && {
  find . -type f -exec truncate -s 0 {} \;
}
