#!/bin/bash
THEME_NAME=cherry
SRC=$(realpath "$(dirname "$0")")

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

[[ ! -d ${AURORAE} ]] && mkdir -p ${AURORAE}
[[ ! -d ${KVANTUM} ]] && mkdir -p ${KVANTUM}
[[ ! -d ${LOOKFEEL} ]] && mkdir -p ${LOOKFEEL}
[[ ! -d ${PLASMA} ]] && mkdir -p ${PLASMA}
[[ ! -d ${SCHEMES} ]] && mkdir -p ${SCHEMES}
[[ ! -d ${WALLPAPER} ]] && mkdir -p ${WALLPAPER}

install() {
  local name=${1}

  [[ -d ${AURORAE}/${name} ]] && rm -rf ${AURORAE}/${name}*
  [[ -d ${KVANTUM}/${name} ]] && rm -rf ${KVANTUM}/${name}*
  [[ -d ${LOOKFEEL}/com.github.nullxception.${name} ]] && rm -rf ${LOOKFEEL}/com.github.nullxception.${name}*
  [[ -d ${PLASMA}/${name} ]] && rm -rf ${PLASMA}/${name}*
  [[ -d ${WALLPAPER}/${name} ]] && rm -rf ${WALLPAPER}/${name}*
  [[ -f ${SCHEMES}/${name}.colors ]] && rm -rf ${SCHEMES}/${name}*.colors

  cp -r ${SRC}/aurorae/themes/*                                                  ${AURORAE}
  cp -r ${SRC}/color-schemes/*.colors                                            ${SCHEMES}
  cp -r ${SRC}/konsole/*                                                         ${KONSOLE}
  cp -r ${SRC}/kvantum/*                                                         ${KVANTUM}
  cp -r ${SRC}/plasma/look-and-feel/*                                            ${LOOKFEEL}
  cp -r ${SRC}/wallpaper/*                                                       ${WALLPAPER}

  cp -r ${SRC}/plasma/desktoptheme/${name}                                       ${PLASMA}
  cp -r ${SRC}/plasma/desktoptheme/${name}-solid                                 ${PLASMA}
  cp -r ${SRC}/plasma/desktoptheme/icons                                         ${PLASMA}/${name}
  cp -r ${SRC}/plasma/desktoptheme/icons                                         ${PLASMA}/${name}-solid
  cp -r ${SRC}/color-schemes/${name}.colors                                      ${PLASMA}/${name}/colors
}

echo "Installing ${THEME_NAME}..."
install "${THEME_NAME}"

echo "Clearing KDE caches..."
find ~/.cache -type f -iname '*.kcache' -delete > /dev/null 2>&1
find ~/.cache -type f -iname '*sma-svgel*' -delete > /dev/null 2>&1
