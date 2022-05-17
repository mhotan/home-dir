#!/bin/sh

# Updates the ~/home-dir with Brew bundle file to list all system 

set -e

# Obtain a reference to the directory containing `update_casks.sh`
BASE_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
BREWFILE_PATH=${BASE_DIR}/etc/brew/Brewfile

command -v brew >/dev/null 2>&1 || { echo >&2 "I require brew but it's not installed.  Aborting."; exit 1; }

echo "Updating Brewfile."
brew bundle dump --file=${BREWFILE_PATH} --force && echo "${BREWFILE_PATH} updated"

