#!/bin/bash

APP="LibreWolf"
ICNS="/Users/cedre/.config/librewolf/LibreWolfIcon.icns"
OUT="firefox.icns"

# update app icon file
cp "${ICNS}" /Applications/"${APP}".app/Contents/Resources/"${OUT}"

# clear the icon cache
sudo rm -rfv /Library/Caches/com.apple.iconservices.store; sudo find /private/var/folders/ \( -name com.apple.dock.iconcache -or -name com.apple.iconservices \) -exec rm -rfv {} \; ; sleep 3;sudo touch /Applications/* ; killall Dock; killall Finder
