#!/bin/sh

if [ -f "/usr/src/.svn" ]; then
  svn cleanup /usr/src
  svn update /usr/src
else
  svn checkout http://svn.freebsd.org/base/release/11.1.0/ /usr/src
fi
