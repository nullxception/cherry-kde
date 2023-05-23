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
  for variant in cherry{,-solid,-square{,-solid},-midnight{,-solid,-square{,-solid}}}; do
    del "$PREFIX/share/aurorae/themes/$variant"
  done

  local KVANTUM="$PREFIX/share/Kvantum"
  # Special Kvantum dest for user-specific install
  [[ $EUID -ne 0 ]] && KVANTUM="$HOME/.config/Kvantum"

  for variant in cherry{,-solid,-midnight{,-solid}}; do
    del "$KVANTUM/$variant"
  done

  for variant in cherry{,midnight}; do
    del "$PREFIX/share/plasma/look-and-feel/com.github.nullxception.${variant}"
  done

  for variant in cherry{,-solid,-midnight{,-solid}}; do
    del "$PREFIX/share/plasma/desktoptheme/$variant"
  done

  for variant in cherry{,-midnight}; do
    del "$PREFIX/share/konsole/${variant}.colorscheme"
  done

  for variant in Cherry{,Midnight}; do
    del "$PREFIX/share/color-schemes/${variant}.colors"
  done

  del "$PREFIX/share/wallpapers/cherry"
}

if [[ $EUID -ne 0 ]]; then
  PREFIX="$HOME/.local"
elif [[ -z "$PREFIX" ]]; then
  PREFIX=/usr
fi

parsed=$(getopt --options=p: --longoptions=prefix: --name "$0" -- "$@")
if [ $? -ne 0 ]; then
  echo 'Invalid argument, exiting.' >&2
  exit 1
fi

eval set -- "$parsed"
unset parsed
while true; do
  case "$1" in
  "-p" | "--prefix")
    PREFIX="$2"
    shift 2
    ;;
  "--")
    shift
    break
    ;;
  *) ;;

  esac
done

main "$@"
