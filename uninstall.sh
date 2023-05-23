#!/bin/bash

del() {
  if [[ -e "$1" ]]; then
    echo "path found, removing $1"
    rm -r "$1"
  else
    echo "path not found: $1"
  fi
}

main() {
  for variant in cherry cherry-midnight cherry-midnight-solid cherry-midnight-square cherry-midnight-square-solid cherry-solid cherry-square cherry-square-solid; do
    del "$PREFIX/share/aurorae/themes/$variant"
  done

  local KVANTUM="$PREFIX/share/Kvantum"
  # Special Kvantum dest for user-specific install
  [[ $EUID -ne 0 ]] && KVANTUM="$HOME/.config/Kvantum"

  for variant in cherry cherry-midnight cherry-midnight-solid cherry-solid; do
    del "$KVANTUM/$variant"
  done

  for variant in cherry cherrymidnight; do
    del "$PREFIX/share/plasma/look-and-feel/com.github.nullxception.${variant}"
  done

  for variant in cherry cherry-midnight cherry-midnight-solid cherry-solid; do
    del "$PREFIX/share/plasma/desktoptheme/$variant"
  done

  for variant in cherry cherry-midnight; do
    del "$PREFIX/share/konsole/${variant}.colorscheme"
  done

  for variant in Cherry CherryMidnight; do
    del "$PREFIX/share/color-schemes/${variant}.colors"
  done

  del "$PREFIX/share/wallpapers/cherry"
}

if [[ $EUID -ne 0 ]]; then
  PREFIX="$HOME/.local"
elif [[ -z "$PREFIX" ]]; then
  PREFIX=/usr
fi

main "$@"
