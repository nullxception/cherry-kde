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

[[ ! -d ${AURORAE_DIR} ]] && mkdir -p ${AURORAE_DIR}
[[ ! -d ${KVANTUM_DIR} ]] && mkdir -p ${KVANTUM_DIR}
[[ ! -d ${LOOKFEEL_DIR} ]] && mkdir -p ${LOOKFEEL_DIR}
[[ ! -d ${PLASMA_DIR} ]] && mkdir -p ${PLASMA_DIR}
[[ ! -d ${SCHEMES_DIR} ]] && mkdir -p ${SCHEMES_DIR}
[[ ! -d ${WALLPAPER_DIR} ]] && mkdir -p ${WALLPAPER_DIR}

install() {
  local name=${1}

  [[ -d ${AURORAE_DIR}/${name} ]] && rm -rf ${AURORAE_DIR}/${name}*
  [[ -d ${KVANTUM_DIR}/${name} ]] && rm -rf ${KVANTUM_DIR}/${name}*
  [[ -d ${LOOKFEEL_DIR}/com.github.nullxception.${name} ]] && rm -rf ${LOOKFEEL_DIR}/com.github.nullxception.${name}*
  [[ -d ${PLASMA_DIR}/${name} ]] && rm -rf ${PLASMA_DIR}/${name}*
  [[ -d ${WALLPAPER_DIR}/${name} ]] && rm -rf ${WALLPAPER_DIR}/${name}*
  [[ -f ${SCHEMES_DIR}/${name}.colors ]] && rm -rf ${SCHEMES_DIR}/${name}*.colors

  cp -r ${SRC_DIR}/aurorae/themes/*                                                  ${AURORAE_DIR}
  cp -r ${SRC_DIR}/color-schemes/*.colors                                            ${SCHEMES_DIR}
  cp -r ${SRC_DIR}/konsole/*                                                         ${KONSOLE_DIR}
  cp -r ${SRC_DIR}/kvantum/*                                                         ${KVANTUM_DIR}
  cp -r ${SRC_DIR}/plasma/look-and-feel/*                                            ${LOOKFEEL_DIR}
  cp -r ${SRC_DIR}/wallpaper/*                                                       ${WALLPAPER_DIR}

  cp -r ${SRC_DIR}/plasma/desktoptheme/${name}                                       ${PLASMA_DIR}
  cp -r ${SRC_DIR}/plasma/desktoptheme/icons                                         ${PLASMA_DIR}/${name}
  cp -r ${SRC_DIR}/color-schemes/${name}.colors                                      ${PLASMA_DIR}/${name}/colors
}

echo "Installing ${THEME_NAME}..."
install "${name:-${THEME_NAME}}"

echo "Clearing KDE caches..."
find ~/.cache -type f -iname '*.kcache' -delete > /dev/null 2>&1
find ~/.cache -type f -iname '*sma-svgel*' -delete > /dev/null 2>&1
