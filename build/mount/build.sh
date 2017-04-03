#!/usr/bin/env bash

unzip -oLq zips/qsw106.zip id1/pak0.pak -d $DEST_DIR/
unzip -oLq zips/qwsv230.zip -x qwsv.exe README.qwsv -d $DEST_DIR/
unzip -oLq zips/sv-gpl.zip qw/maps/* -d $DEST_DIR/
unzip -oLq zips/sv-non-gpl.zip qw/maps/* -d $DEST_DIR/

for f in $DEST_DIR/qw/*; do
  mv "$f" "$f.tmp"; mv "$f.tmp" "`echo $f | tr "[:upper:]" "[:lower:]"`";
done

cp -f scripts/*.sh $DEST_DIR/
chmod +x $DEST_DIR/*.sh

rm -rf $DEST_DIR/templates
cp -R templates $DEST_DIR/templates

GOPATH=$BUILD_DIR go install zobe.es/quakeworld/configurator
cp -f $BUILD_DIR/bin/configurator $DEST_DIR/configurator