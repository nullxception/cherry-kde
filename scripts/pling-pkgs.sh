#!/bin/bash
name="cherry"
src="$(realpath "$(dirname "$0")/..")"
dist="$src/dist"
tmp="$(mktemp -d /tmp/nullxception.kde-$name-XXX)"

get_version() {
  local fmeta="$1/metadata.desktop"
  local fversion="$1/.version"

  if [[ -f "$fmeta" ]]; then
    grep "PluginInfo-Version=" $fmeta | cut -d= -f2
  elif [[ -f "$fversion" ]]; then 
    cat $fversion
  fi
}

rm -rf $dist; mkdir $dist
chmod +x "$src/install.sh"

# deploy theme to tempdir for packaging
PREFIX="$tmp" $src/install.sh >/dev/null

# Packaging all the components
cd "$tmp/share/aurorae/themes"
ver=$(get_version $src/aurorae/cherry)
tar -czvf "$dist/$name-aurorae-$ver.tar.gz" . >/dev/null

cd "$tmp/share/konsole"
ver=$(get_version $src/konsole)
tar -czvf "$dist/$name-konsole-$ver.tar.gz" . >/dev/null

cd "$tmp/share/color-schemes"
ver=$(get_version $src/color-schemes)
tar -czvf "$dist/$name-color-schemes-$ver.tar.gz" . >/dev/null

for variant in cherry{,-solid}; do
  cd "$tmp/share/plasma/desktoptheme"
  ver=$(get_version $src/plasma/desktoptheme/$variant)
  tar -czvf "$dist/$variant-plasma-$ver.tar.gz" $variant >/dev/null
done

cd "$tmp/share/plasma/look-and-feel"
ver=$(get_version $src/plasma/look-and-feel/com.github.nullxception.cherry)
tar -czvf "$dist/$name-look-and-feel-$ver.tar.gz" . >/dev/null

cd "$tmp/share/wallpapers"
ver=$(get_version $src/wallpaper/cherry)
tar -czvf "$dist/$name-wallpaper-$ver.tar.gz" . >/dev/null

# Pack kvantum theme directly
cd "$src/kvantum"
ver=$(get_version $src/kvantum)
tar -czvf "$dist/$name-kvantum-$ver.tar.gz" . >/dev/null

# cleaning up
rm -rf "$tmp"
