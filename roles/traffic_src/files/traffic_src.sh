#!/usr/local/bin/bash

while true; do

  target=$[ ( $RANDOM % 3 ) + 1 ]

  #ping -c1 traffic-sink-$target
  curl http://traffic-sink-$target/index.html
  ssh root@traffic-sink-$target -- echo "hello"

  sleep $[ ( $RANDOM % 10 ) ]
done
