#!/bin/bash

hex2rgb() {
    local hex=${1^^}
    local r=0x${hex:0:2}
    local g=0x${hex:2:2}
    local b=0x${hex:4:2}

    if [[ "$2" == "faint" ]]; then
        r=$((r - 0x5))
        g=$((g - 0x5))
        b=$((b - 0x5))
        [[ "$r" -gt 255 ]] && r=255
        [[ "$g" -gt 255 ]] && g=255
        [[ "$b" -gt 255 ]] && b=255
    fi

    printf "%d,%d,%d\n" $r $g $b
}

konsolecolor() {
    local line="$1"
    local num="$(cut -d' ' -f1 <<<"$line")"
    local num="${num##color}"
    local key="${num}"
    local hex="$(cut -d'#' -f2 <<<"$line")"

    local color="$(hex2rgb "${hex}")"
    local color_faint="$(hex2rgb "${hex}" faint)"

    if [[ "$num" == "background" ]]; then
        printf "[%s]\nColor=%s\n\n" "Background" "$color"
        printf "[%s]\nColor=%s\n\n" "BackgroundFaint" "$color_faint"
        printf "[%s]\nColor=%s\n\n" "BackgroundIntense" "$color"
    elif [[ "$num" == "foreground" ]]; then
        printf "[%s]\nColor=%s\n\n" "Foreground" "$color"
        printf "[%s]\nColor=%s\n\n" "ForegroundFaint" "$color_faint"
        printf "[%s]\nColor=%s\n\n" "ForegroundIntense" "$color"
    elif [[ "$num" -ge 8 ]]; then
        key=$((num - 8))
        printf "[%s]\nColor=%s\n\n" "Color${key}Intense" "$color"
        printf "[%s]\nColor=%s\n\n" "Color${key}Faint" "$color_faint"
    else
        printf "[%s]\nColor=%s\n\n" "Color${key}" "$color"
    fi
}

main() {
    cp "$konsole_src" "${konsole_src}.bak"
    meta_blur=$(grep -E 'Blur=' "${konsole_src}.bak" | cut -d= -f2)
    meta_desc=$(grep -E '^Description=' "${konsole_src}.bak" | cut -d= -f2)
    meta_opacity=$(grep -E 'Opacity=' "${konsole_src}.bak" | cut -d= -f2)

    echo "[General]" >"$konsole_src"
    [[ -n "$meta_blur" ]] && echo "Blur=${meta_blur}" >>"$konsole_src"
    [[ -n "$meta_desc" ]] && echo "Description=${meta_desc}" >>"$konsole_src"
    [[ -n "$meta_opacity" ]] && echo "Opacity=${meta_opacity}" >>"$konsole_src"
    echo -e "ColorRandomization=false\n" >>"$konsole_src"

    cat "${kitty_src}" | while read -r line; do
        if grep -qE '^color[0-9]+.*#.*$' <<<"$line" ||
            grep -qE '^[f|b].*ground.*#.*$' <<<"$line"; then
            konsolecolor "$line" >>"$konsole_src"
        fi
    done
}

kitty_src="$1"
konsole_src="$2"
main "$@"
