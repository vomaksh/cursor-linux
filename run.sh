#!/bin/bash

RESPONSE=$(curl -s 'https://cursor.com/api/download?platform=linux-x64&releaseTrack=stable')
CURSOR_VERSION=$(echo $RESPONSE | jq -r '.version')
CURSOR_DOWNLOAD_URL=$(echo $RESPONSE | jq -r '.downloadUrl')

# update spec version
sed -i "/^Version: /c\Version: \\$CURSOR_VERSION" cursor.spec

# downloading cursor appimage
echo "version: $CURSOR_VERSION"
echo "download url: $CURSOR_DOWNLOAD_URL"
mkdir out
curl -o out/cursor.AppImage $CURSOR_DOWNLOAD_URL

# extract appimage to directory
chmod +x out/cursor.AppImage
./out/cursor.AppImage --appimage-extract
mv squashfs-root out/

# build source tar.gz
mv out/squashfs-root "out/cursor-$CURSOR_VERSION"
tar -cvzf "$HOME/rpmbuild/SOURCES/cursor-$CURSOR_VERSION.tar.gz" -C out cursor-$CURSOR_VERSION
rm -rf out

# build rpm package
cp cursor.spec $HOME/rpmbuild/SPECS
cd $HOME/rpmbuild/SPECS
rpmbuild -ba $HOME/rpmbuild/SPECS/cursor.spec

ls -l $HOME/rpmbuild/RPMS
