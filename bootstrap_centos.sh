#!/bin/sh

ssh -o "UserKnownHostsFile /dev/null" -o StrictHostKeyChecking=no centos-unnamed -- yum update -y

