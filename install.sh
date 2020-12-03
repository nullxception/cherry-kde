#!/bin/bash
THEME_NAME=cherry
SRC=$(realpath "$(dirname "$0")")

if [[ -z "$PREFIX" && $EUID -ne 0 ]]; then
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
[[ ! -d ${KONSOLE} ]] && mkdir -p ${KONSOLE}
[[ ! -d ${LOOKFEEL} ]] && mkdir -p ${LOOKFEEL}
[[ ! -d ${PLASMA} ]] && mkdir -p ${PLASMA}
[[ ! -d ${SCHEMES} ]] && mkdir -p ${SCHEMES}
[[ ! -d ${WALLPAPER} ]] && mkdir -p ${WALLPAPER}

in_aurorae() {
  local name=${1}
  local variants=("solid"
                  "square"
                  "square-solid")

  [[ -d ${AURORAE}/${name} ]] && rm -rf ${AURORAE}/${name}
  cp -r ${SRC}/aurorae/${name} ${AURORAE}

  for variant in "${variants[@]}"; do
    [[ -d ${AURORAE}/${name}-${variant} ]] && rm -rf ${AURORAE}/${name}-${variant}
    cp -r ${SRC}/aurorae/${name} ${AURORAE}/${name}-${variant}
    cp -r ${SRC}/aurorae/${name}-${variant}/. ${AURORAE}/${name}-${variant}
    rm ${AURORAE}/${name}-${variant}/${name}rc
  done
}

in_kvantum() {
  local name=${1}
  local variants=("solid")

  [[ -d ${KVANTUM}/${name} ]] && rm -rf ${KVANTUM}/${name}
  cp -r ${SRC}/kvantum/${name} ${KVANTUM}

  for variant in "${variants[@]}"; do
    [[ -d ${KVANTUM}/${name}-${variant} ]] && rm -rf ${KVANTUM}/${name}-${variant}
    cp -r ${SRC}/kvantum/${name}-${variant} ${KVANTUM}
  done
}

in_plasma() {
  local name=${1}
  local variants=("solid")

  [[ -d ${PLASMA}/${name} ]] && rm -rf ${PLASMA}/${name}
  cp -r ${SRC}/plasma/desktoptheme/${name} ${PLASMA}
  cp -r ${SRC}/color-schemes/${name}.colors ${PLASMA}/${name}/colors

  for variant in "${variants[@]}"; do
    [[ -d ${PLASMA}/${name} ]] && rm -rf ${PLASMA}/${name}-${variant}
    cp -r ${SRC}/plasma/desktoptheme/${name} ${PLASMA}/${name}-${variant}
    cp -r ${SRC}/plasma/desktoptheme/${name}-${variant}/. ${PLASMA}/${name}-${variant}

    if [[ -f ${SRC}/color-schemes/${name}-${variant}.colors ]]; then
      cp -r ${SRC}/color-schemes/${name}-${variant}.colors ${PLASMA}/${name}/colors
    fi
  done
}

in_global() {
  local name=${1}
  local domain=com.github.nullxception

  [[ -d ${LOOKFEEL}/${domain}.${name} ]] && rm -rf ${LOOKFEEL}/${domain}.${name}
  cp -r ${SRC}/plasma/look-and-feel/${domain}.${name} ${LOOKFEEL}
}

in_colors() {
  local name=${1}

  cp -r ${SRC}/color-schemes/${name}.colors ${SCHEMES}
  cp -r ${SRC}/konsole/${name}.colorscheme ${KONSOLE}
}

in_wallpaper() {
  local name=${1}

  [[ -d ${WALLPAPER}/${name} ]] && rm -rf ${WALLPAPER}/${name}
  cp -r ${SRC}/wallpaper/${name} ${WALLPAPER}
}

echo "Installing ${THEME_NAME}"
in_aurorae    "${THEME_NAME}"
in_colors     "${THEME_NAME}"
in_global     "${THEME_NAME}"
in_kvantum    "${THEME_NAME}"
in_plasma     "${THEME_NAME}"
in_wallpaper  "${THEME_NAME}"

echo "Clearing KDE caches"
find ~/.cache -type f -iname '*.kcache' -delete > /dev/null 2>&1
find ~/.cache -type f -iname '*sma-svgel*' -delete > /dev/null 2>&1
