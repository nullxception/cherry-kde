#!/bin/bash
name=cherry
src=$(realpath "$(dirname "$0")/..")
dist=$src/dist
tmp=$(mktemp -d /tmp/nullxception.kde-$name-XXX)

rm -rf $dist; mkdir $dist
chmod +x $src/install.sh

# deploy theme to tempdir for packaging
PREFIX=$tmp $src/install.sh >/dev/null

# Packaging all the components
cd $tmp/share/aurorae/themes
tar -czvf $dist/$name-aurorae.tar.gz . >/dev/null
cd $tmp/share/konsole
tar -czvf $dist/$name-konsole.tar.gz . >/dev/null
cd $tmp/share/color-schemes
tar -czvf $dist/$name-color-schemes.tar.gz . >/dev/null
for v in cherry{,-solid}; do
  cd $tmp/share/plasma/desktoptheme
  tar -czvf $dist/$v-plasma.tar.gz $v >/dev/null
done
cd $tmp/share/plasma/look-and-feel
tar -czvf $dist/$name-look-and-feel.tar.gz . >/dev/null
cd $tmp/share/wallpapers
tar -czvf $dist/$name-wallpaper.tar.gz . >/dev/null

# cleaning up
rm -rf $tmp
