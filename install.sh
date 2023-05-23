#!/bin/bash
src=$(realpath "$(dirname "$0")")
components=(aurorae colors global kvantum plasma wallpaper)

install_aurorae() {
  local dest="$PREFIX/share/aurorae/themes"

  echo "Installing cherry:aurorae"

  mkdir -p "$dest"

  for variant in cherry{,-solid,-square{,-solid},-midnight{,-solid,-square{,-solid}}}; do
    if [[ -d "$dest/${variant}" ]]; then
      rm -rf "$dest/${variant}"
    fi

    cp -r "$src/aurorae/cherry" "$dest/${variant}"
    cp -r "$src/aurorae/${variant}"/. "$dest/${variant}"
    if [[ "$variant" != "cherry" ]]; then
      rm "$dest/${variant}/cherryrc"
    fi
  done
}

install_kvantum() {
  local dest="$PREFIX/share/Kvantum"

  echo "Installing cherry:kvantum"

  # Destination directory
  # Special Kvantum dest for user-specific install
  [[ $EUID -ne 0 ]] && dest="$HOME/.config/Kvantum"

  mkdir -p "$dest"

  for variant in cherry{,-solid,-midnight{,-solid}}; do
    if [[ -d "$dest/${variant}" ]]; then
      rm -rf "$dest/${variant}"
    fi

    cp -r "$src/kvantum/${variant}" "$dest"
  done
}

install_plasma() {
  local dest="$PREFIX/share/plasma/desktoptheme"

  echo "Installing cherry:plasma"

  mkdir -p "$dest"

  for variant in cherry{,-solid,-midnight{,-solid}}; do
    if [[ -d "$dest/${variant}" ]]; then
      rm -rf "$dest/${variant}"
    fi

    cp -r "$src/plasma/desktoptheme/cherry" "$dest/${variant}"
    cp -r "$src/plasma/desktoptheme/${variant}"/. "$dest/${variant}"

    if [[ "$variant" == "midnig"* ]]; then
      cp -r "$src/color-schemes/CherryMidnight.colors" "$dest/${variant}/colors"
    else
      cp -r "$src/color-schemes/Cherry.colors" "$dest/${variant}/colors"
    fi
  done
}

install_global() {
  local dest="$PREFIX/share/plasma/look-and-feel"
  local namespace=com.github.nullxception

  echo "Installing cherry:global"

  mkdir -p "$dest"

  for variant in cherry{,midnight}; do
    if [[ -d "$dest/${namespace}.${variant}" ]]; then
      rm -rf "$dest/${namespace}.${variant}"
    fi
    cp -r "$src/plasma/look-and-feel/${namespace}.${variant}" "$dest"
  done
}

install_colors() {
  local konsole_dest="$PREFIX/share/konsole"
  local scheme_dest="$PREFIX/share/color-schemes"

  echo "Installing cherry:colors"

  mkdir -p "$konsole_dest" "$scheme_dest"

  cp -r "$src/color-schemes/Cherry.colors" "$scheme_dest"
  cp -r "$src/color-schemes/CherryMidnight.colors" "$scheme_dest"

  cp -r "$src/konsole/cherry.colorscheme" "$konsole_dest"
  cp -r "$src/konsole/cherry-midnight.colorscheme" "$konsole_dest"
}

install_wallpaper() {
  local dest="$PREFIX/share/wallpapers"

  echo "Installing cherry:wallpaper"

  mkdir -p "$dest"

  [[ -d "$dest/cherry" ]] && rm -rf "$dest/cherry"
  cp -r "$src/wallpaper/cherry" "$dest"
}

main() {
  if [[ -z "$PREFIX" && $EUID -ne 0 ]]; then
    PREFIX="$HOME/.local"
  elif [[ -z "$PREFIX" ]]; then
    PREFIX=/usr
  fi

  for fn in "${components[@]}"; do
    if declare -F "install_${fn}" >/dev/null; then
      install_${fn}
    else
      echo "components $fn cannot be found. exiting" >&2
      exit 1
    fi
  done

  if [[ "$clear_cache" == "true" ]]; then
    echo "Clearing KDE caches"
    find ~/.cache -type f -iname '*.kcache' -delete >/dev/null 2>&1
    find ~/.cache -type f -iname '*sma-svgel*' -delete >/dev/null 2>&1
  fi
}

clear_cache=true

parsed=$(getopt --options=p:,c:,s: --longoptions=prefix:,clear-cache:,components: --name "$0" -- "$@")
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
  "-c" | "--clear-cache")
    clear_cache="$2"
    shift 2
    ;;
  "-s" | "--components")
    IFS=',' read -ra components <<<"$2"
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
