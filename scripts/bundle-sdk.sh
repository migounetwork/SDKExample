#!/bin/bash
set -x
DEST=$CONFIGURATION_BUILD_DIR/$UNLOCALIZED_RESOURCES_FOLDER_PATH
TARBALL="../sdk.tar.gz"

if [ -f ${TARBALL} ];
then
  tar -xvf ${TARBALL} -C ${DEST}
  if [ $? -eq 0 ];
  then
    exit 0
  else
    echo "Untar Tarball failed."
    exit 200
  fi
else
  echo "Tarball ${TARBALL} not existing."
  exit 100
fi
