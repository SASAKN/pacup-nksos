#!/bin/bash

if [ ! -f ./pacup ]; then
  echo -e "\"pacup\" ファイルが見つかりませんでした\n"
  exit 1
fi

command -v snap >/dev/null 2>&1
if [ $? == 0 ] && [ ! -f /usr/bin/wslfetch ]; then
   sed -i -e "/^  : #SYS$/a \ \ sudo snap refresh" ./pacup
fi
command -v flatpak >/dev/null 2>&1
if [ $? == 0 ]; then
   sed -i -e "/^  : #FPK$/a \ \ flatpak update" ./pacup
fi

cp -f ./pacup /usr/local/bin/pacup
chmod +rx /usr/local/bin/pacup

if [ ! -d /usr/local/share/applications ]; then
    mkdir -p /usr/local/share/applications
fi

cp -f ./pacup.desktop /usr/local/share/applications

echo "Success!"
exit 0
