#!/bin/bash

ROOT_UID=0

# Destination directory
if [ "$UID" -eq "$ROOT_UID" ]; then
  AURORAE_DIR="/usr/share/aurorae/themes"
  KONSOLE_DIR="/usr/share/konsole"
  KVANTUM_DIR="/usr/share/Kvantum"
  LAYOUT_DIR="/usr/share/plasma/layout-templates"
  LOOKFEEL_DIR="/usr/share/plasma/look-and-feel"
  PLASMA_DIR="/usr/share/plasma/desktoptheme"
  SCHEMES_DIR="/usr/share/color-schemes"
  WALLPAPER_DIR="/usr/share/wallpapers"
else
  AURORAE_DIR="$HOME/.local/share/aurorae/themes"
  KONSOLE_DIR="$HOME/.local/share/konsole"
  KVANTUM_DIR="$HOME/.config/Kvantum"
  LAYOUT_DIR="$HOME/.local/share/plasma/layout-templates"
  LOOKFEEL_DIR="$HOME/.local/share/plasma/look-and-feel"
  PLASMA_DIR="$HOME/.local/share/plasma/desktoptheme"
  SCHEMES_DIR="$HOME/.local/share/color-schemes"
  WALLPAPER_DIR="$HOME/.local/share/wallpapers"
fi

SRC_DIR=$(cd $(dirname $0) && pwd)

THEME_NAME=cherry

uninstall() {
  local name=${1}

  local AURORAE_THEME="${AURORAE_DIR}/${name}"
  local PLASMA_THEME="${PLASMA_DIR}/${name}"
  local LOOKFEEL_THEME="${LOOKFEEL_DIR}/com.github.nullxception.${name}"

  [[ -d ${AURORAE_THEME} ]] && rm -rfv ${AURORAE_THEME}
  [[ -d ${KONSOLE_DIR}/${name}.colorscheme ]] && rm -rfv ${SCHEMES_DIR}/${name}.colorscheme
  [[ -d ${KVANTUM_THEME}/${name} ]] && rm -rfv ${KVANTUM_THEME}/${name}
  [[ -d ${LOOKFEEL_THEME} ]] && rm -rfv ${LOOKFEEL_THEME}
  [[ -d ${PLASMA_THEME} ]] && rm -rfv ${PLASMA_THEME}
  [[ -d ${SCHEMES_DIR}/${name}.colors ]] && rm -rfv ${SCHEMES_DIR}/${name}.colors
  [[ -d ${WALLPAPER_DIR}/cherry ]] && rm -rfv ${WALLPAPER_DIR}/cherry
}

echo "Uninstalling ${THEME_NAME}..."
uninstall "${name:-${THEME_NAME}}"
