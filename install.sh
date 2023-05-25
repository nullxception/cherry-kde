#!/bin/bash
src=$(realpath "$(dirname "$0")")
components=(aurorae colors global kvantum plasma wallpaper)

install_aurorae() {
  local dest="$PREFIX/share/aurorae/themes"

  echo "Installing cherry:aurorae"

  install -dm0755 "$dest"

  for variant in cherry{,-solid,-square{,-solid},-midnight{,-solid,-square{,-solid}}}; do
    cp -rL "$src/aurorae/${variant}" "$dest"
  done
}

install_kvantum() {
  local dest="$PREFIX/share/Kvantum"

  echo "Installing cherry:kvantum"

  # Destination directory
  # Special Kvantum dest for user-specific install
  [[ $EUID -ne 0 ]] && dest="$HOME/.config/Kvantum"

  install -dm0755 "$dest"

  for variant in cherry{,-solid,-midnight{,-solid}}; do
    cp -rL "$src/kvantum/${variant}" "$dest"
  done
}

install_plasma() {
  local dest="$PREFIX/share/plasma/desktoptheme"

  echo "Installing cherry:plasma"

  install -dm0755 "$dest"

  for variant in cherry{,-midnight}; do
    cp -rL "$src/plasma/desktoptheme/${variant}" "$dest"
  done
}

install_global() {
  local dest="$PREFIX/share/plasma/look-and-feel"
  local namespace=com.github.nullxception

  echo "Installing cherry:global"

  install -dm0755 "$dest"

  for variant in cherry{,midnight}; do
    cp -rL "$src/plasma/look-and-feel/${namespace}.${variant}" "$dest"
  done
}

install_colors() {
  local konsole_dest="$PREFIX/share/konsole"
  local scheme_dest="$PREFIX/share/color-schemes"

  echo "Installing cherry:colors"

  install -dm0755 "$konsole_dest"
  install -dm0755 "$scheme_dest"

  cp -r "$src/color-schemes/Cherry.colors" "$scheme_dest"
  cp -r "$src/color-schemes/CherryMidnight.colors" "$scheme_dest"

  cp -r "$src/konsole/cherry.colorscheme" "$konsole_dest"
  cp -r "$src/konsole/cherry-midnight.colorscheme" "$konsole_dest"
}

install_wallpaper() {
  local dest="$PREFIX/share/wallpapers"

  echo "Installing cherry:wallpaper"

  install -dm0755 "$dest"
  cp -rL "$src/wallpaper/cherry" "$dest"
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
      echo "components $fn cannot be found" >&2
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
