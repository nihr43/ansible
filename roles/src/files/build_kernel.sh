#!/bin/sh

if [ -f "/usr/src/.svn" ]; then
  echo "No source tree found."
else
  cd /usr/src
  make cleanworld
  make -j6 buildkernel KERNCONF=BHYVE_GUEST
fi
