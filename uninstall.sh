#!/bin/bash

THEME_NAME=cherry

if [[ $EUID -ne 0 ]]; then
  PREFIX="$HOME/.local"
elif [[ -z "$PREFIX" ]]; then
  PREFIX=/usr
fi

# Destination directory
AURORAE="$PREFIX/share/aurorae/themes"
KONSOLE="$PREFIX/share/konsole"
KVANTUM="$PREFIX/share/Kvantum"
LOOKFEEL="$PREFIX/share/plasma/look-and-feel"
PLASMA="$PREFIX/share/plasma/desktoptheme"
SCHEMES="$PREFIX/share/color-schemes"
WALLPAPER="$PREFIX/share/wallpapers"
# Special Kvantum dest for user-specific install
[[ $EUID -ne 0 ]] && KVANTUM="$HOME/.config/Kvantum"

del() {
  if [[ -e "$1" ]]; then
    echo "path found, removing $1"
    rm -r "$1"
  else
    echo "path not found: $1"
  fi
}

del ${AURORAE}/${THEME_NAME}
del ${AURORAE}/${THEME_NAME}-solid
del ${AURORAE}/${THEME_NAME}-square
del ${AURORAE}/${THEME_NAME}-square-solid
del ${KVANTUM}/${THEME_NAME}
del ${KVANTUM}/${THEME_NAME}-solid
del ${LOOKFEEL}/com.github.nullxception.${THEME_NAME}
del ${PLASMA}/${THEME_NAME}
del ${PLASMA}/${THEME_NAME}-solid
del ${SCHEMES}/${THEME_NAME}.colors
del ${WALLPAPER}/${THEME_NAME}
