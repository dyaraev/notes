#!/usr/bin/env bash

set -e

# parameters
file_path=$1
disk_label=$2

# create an empty image file
dd if=/dev/zero of="${file_path}" bs=1024 count=1440

# attach the image
device=$(hdiutil attach -nomount "${file_path}")

# display attached drives
diskutil list

# format the image
newfs_msdos -f 1440 -v "${disk_label}" ${device}

# detach the image
hdiutil detach ${device}

# display attached drives
diskutil list

echo "Created a floppy image at ${file_path} with label '${disk_label}'"
