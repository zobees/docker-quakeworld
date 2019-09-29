#!/usr/bin/env bash

if [ ! -f "$QW_DIR/id1/pak1.pak" ]; then
  if [ -f "$QW_MOUNT/pak1.pak" ]; then
    cp -f $QW_MOUNT/pak1.pak $QW_DIR/id1/pak1.pak
  else
    echo "ERROR: no pak1 found!"
    exit 1
  fi
fi

find ./templates -type f -print0 | while IFS= read -r -d $'\0' line; do
  ./configurator $line ${line#./templates/}
done

./mvdsv +gamedir $QW_GAMENAME -mem 128 -port $PORT +exec server.cfg -nopriority -noerrormsgbox +logrcon +logplayers +logerrors -progs qwprogs