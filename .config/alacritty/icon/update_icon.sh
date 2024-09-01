#!/bin/bash

# extract the icon image files
# unzip -d alacritty.iconset alacritty_icons.zip

# compile icon file
iconutil -c icns alacritty.iconset -o alacritty.icns

# update app icon file
cp alacritty.icns /Applications/Alacritty.app/Contents/Resources/alacritty.icns

# clear the icon cache
sudo rm -rfv /Library/Caches/com.apple.iconservices.store; sudo find /private/var/folders/ \( -name com.apple.dock.iconcache -or -name com.apple.iconservices \) -exec rm -rfv {} \; ; sleep 3;sudo touch /Applications/* ; killall Dock; killall Finder
