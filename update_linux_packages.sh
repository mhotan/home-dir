#!/bin/sh

# Creates snapshots of snap and apt packages to re-use for different machines

set -e

if [ "$EUID" -ne 0 ]; then
  echo "Please run as root"
  exit
fi

# Obtain a reference to the directory containing `update_casks.sh`
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/etc"
SNAPFILE_DIR="${DIR}/snapd"
mkdir -p $SNAPFILE_DIR
SNAP_FILE_PATH=${SNAPFILE_DIR}/Snapfile

echo "Updating ${SNAP_FILE_PATH}"
snap list | awk '!/disabled/{print $1}' | sed '1d' > $SNAP_FILE_PATH

APT_DIR="${DIR}/apt"
APT_FILE_NAME="${APT_DIR}/apt_packages"
mkdir -p $APT_DIR
sudo apt-clone clone --with-dpkg-repack ${APT_FILE_NAME}