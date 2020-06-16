#!/bin/bash

set -e

echo " Now initiating fdisk utility to create partitions for installation "
fdisk -l
read -p " Note the label and size of the installation drive
            Example :- It should start with /dev/sdx " -n1 -s